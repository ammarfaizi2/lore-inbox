Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVCTE5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVCTE5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 23:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCTE5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 23:57:33 -0500
Received: from h80ad2443.async.vt.edu ([128.173.36.67]:36622 "EHLO
	h80ad2443.async.vt.edu") by vger.kernel.org with ESMTP
	id S262024AbVCTE5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 23:57:30 -0500
Message-Id: <200503200457.j2K4vOmX025692@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ioan Ionita <opslynx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unreliable TCP? 
In-Reply-To: Your message of "Sat, 19 Mar 2005 21:59:16 EST."
             <df47b87a050319185918be6c19@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <df47b87a050319185918be6c19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1111294643_30952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Mar 2005 23:57:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1111294643_30952P
Content-Type: text/plain; charset=us-ascii

On Sat, 19 Mar 2005 21:59:16 EST, Ioan Ionita said:

> applications which use the UDP protocol.  However, certain firewalls
> don't allow UDP traffic, therefore I tried UDP over TCP as a
> workaround.

That's the firewall's problem, not yours.  There's very few firewalls
that prohibit *all* UDP traffic (for starters, DNS becomes interesting).
Usually a firewall stops *most* UDP traffic only because the firewall admin
has decided that there's few UDP-based applications that they want to allow
through...

Explain why you think that your application will be let through the firewall
if it's TCP-based?  If the firewall admin thinks enough of your application to
open a port, it's equally likely to get you an open UDP port.

(For bonus points, work out the ethics of trying to circumvent a firewall that's
there for presumably good reasons - the people who installed the firewall did so
because they only want to allow certain traffic through.  Having the user
ask "Can I have port 99343 opened so application XYZ works?" is much more likely
to be useful *LONG-TERM* than getting into a long-term pissing match with the
firewall admin, who gets upset at your attempts to bypass his firewall and
starts playing whack-a-mole.  If you *do* get UDP-over-TCP working, you're
looking at having to move the port around all the time because it will get
blocked...)

>                                             So I was wondering if
> there's any way to disable the whole reliability checking of TCP in
> the linux kernel. Maybe configure the kernel to never request the
> retransmission of a packet, even if it detects packet loss/bad order?

Yes, it's called UDP. :)


--==_Exmh_1111294643_30952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCPQKzcC3lWbTT17ARAi8VAJ4w5w+hsTPrOwqUjPDb8cfmiVCFnACeK4ux
4Dr2BPiO9XfRajfTm5j2ah0=
=lKfq
-----END PGP SIGNATURE-----

--==_Exmh_1111294643_30952P--
