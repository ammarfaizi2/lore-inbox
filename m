Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVCAGjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVCAGjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVCAGjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:39:12 -0500
Received: from main.gmane.org ([80.91.229.2]:28547 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261261AbVCAGjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:39:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Date: Tue, 01 Mar 2005 07:38:46 +0100
Message-ID: <42240DF6.9010207@free.fr>
References: <20050228231721.GA1326@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7C2B8442A6AF536C019E9727"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lns-vlq-37-lyo-82-253-113-132.adsl.proxad.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
In-Reply-To: <20050228231721.GA1326@elf.ucw.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C2B8442A6AF536C019E9727
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Le 01.03.2005 00:17, Pavel Machek a écrit :
> Hi!
>
> In `subj` kernel, machine no longer powers down at the end of
> swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
>
> 								Pavel

Hello,

I noticed this behaviour, too. Can't remember if it came with
2.6.11-rc3-mm2 or with 2.6.11-rc4-mm1. Didn't try another kernel.

I was able to workaround this problem by doing
"echo platform > /sys/power/disk"
before
"echo disk > /sys/power/state"

The box is a desktop with an asus A7V133 mb (VIA 82Cxxx chipset), Athlon
XP 1600+ CPU and NVidia Geforce2 MX400 graphics.

~~
laurent

--------------enig7C2B8442A6AF536C019E9727
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCJA4AUqUFrirTu6IRArWPAKClhRrIDSN9WFyfqgltgnM0gXidmwCfVB0N
ccuMNcHtiXB2/sESpGXmL4o=
=cOTR
-----END PGP SIGNATURE-----

--------------enig7C2B8442A6AF536C019E9727--

