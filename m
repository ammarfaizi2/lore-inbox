Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135250AbRDLScG>; Thu, 12 Apr 2001 14:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135254AbRDLSb5>; Thu, 12 Apr 2001 14:31:57 -0400
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:26757 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S135250AbRDLSbo>; Thu, 12 Apr 2001 14:31:44 -0400
Message-Id: <200104121831.f3CIVOo12837@foo-bar-baz.cc.vt.edu>
X-Mailer: exmh version 2.3.1 01/19/2001 with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad? 
In-Reply-To: Your message of "Thu, 12 Apr 2001 16:12:55 BST."
             <E14nimI-0000oY-00@the-village.bc.nu> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
In-Reply-To: <E14nimI-0000oY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-450342912P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2001 14:31:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-450342912P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Apr 2001 16:12:55 BST, Alan Cox said:

> Do you have > 800Mb of RAM ?

Following up - it just bit again (twice)

The first time, it was xmms/kswapd fighting for CPU, and xmms was again immune
to kill -9.  Interestingly enough, several minutes later, I closed 'netscape',
and xmms took the kill within a second or two.

10 minutes later, and another 2 programs that do audio got
wedged up. Oddly enough, I did an 'su', and they broke loose immediately.

I've ruled out i810_audio.c as a culprit - although I have programs that
do audio hanging, *those* programs are always writing their data down
a Unix socket to the actual process that writes to /dev/audio/dsp.
Hmm.. 'su' writes to syslog, and netscape has a few Unix sockets too.
Could the problem be related to running out of some resource related
to Unix-domain sockets, which clears up once some socket is closed?

Oddly enough, while I had 2 programs doing audio wedged, I was still
seeing (hearing actually ;) *new* processes open a connection to esd
and play sounds.  Weird.  


-- 
				Valdis Kletnieks
				Operating Systems Analyst
				Virginia Tech




--==_Exmh_-450342912P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8
Comment: Exmh version 2.2 06/16/2000

iQA/AwUBOtX0fHAt5Vm009ewEQIcUACg0dzxnqZyWg1ng8bSyotvuLv0VAkAoOyt
Ox9zED71q//P1Ng48+cQyQhS
=i0et
-----END PGP SIGNATURE-----

--==_Exmh_-450342912P--
