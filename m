Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVFQNGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVFQNGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVFQNGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:06:46 -0400
Received: from h80ad262c.async.vt.edu ([128.173.38.44]:26377 "EHLO
	h80ad262c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261951AbVFQNGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:06:38 -0400
Message-Id: <200506171306.j5HD6E01001899@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lars Roland <lroland@gmail.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup 
In-Reply-To: Your message of "Fri, 17 Jun 2005 03:47:00 +0200."
             <4ad99e0505061618475716f13c@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <4ad99e0505061605452e663a1e@mail.gmail.com> <42B1F5CB.9020308@g-house.de> <4ad99e0505061615143cc34192@mail.gmail.com> <42B21130.4000608@g-house.de> <4ad99e0505061617052f427ed6@mail.gmail.com> <42B218C5.9020406@linuxwireless.org>
            <4ad99e0505061618475716f13c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119013571_11929P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jun 2005 09:06:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119013571_11929P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Jun 2005 03:47:00 +0200, Lars Roland said:
> 
> 
> On 6/17/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> > one question,
> > 
> >     Can I know what is the problem? 
> >:I have 2 tg3 adapters, lots e100's and some Cisco PIX and devices.
> > 
> > I can try to reproduce it and see if anyone has something to say about it.
> 
> Yes please. As I see it. Enable smtp fixup protocol on your cisco pix
> (you will need to have a smtp server to point it to), then on some
> linux system running with a kernel greater than 2.6.8.1 do a telnet to
> the smtp server that is firewalled and try to issue a smtp command.
> 
> Note that cisco has a bug report on smtp fixup banner hiding issues in
> cisco os 6.3.4 but it should not result in the connection getting
> dropped, it also does not explain why this problem does not seam to
> exists on kernels prior to 2.6.9.

2.6.9? This rings a bell.. ;)

Does disabling TCP window scaling fix it?

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

A number of firewalls just stomp on the scaling bits - the end result is
that the perceived window size is too small to make any progress and the
connection wedges up.

--==_Exmh_1119013571_11929P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCssrDcC3lWbTT17ARAkKQAJ9gsLZKse871jkqkhNnvn0qOGlZLwCg+nZM
JsSd2U2Z5a7yjcqEcceE3n4=
=z0MM
-----END PGP SIGNATURE-----

--==_Exmh_1119013571_11929P--
