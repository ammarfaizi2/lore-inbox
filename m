Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUDDWt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUDDWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:49:58 -0400
Received: from smtp-hub2.mrf.mail.rcn.net ([207.172.4.76]:38386 "EHLO
	smtp-hub2.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S262897AbUDDWt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:49:56 -0400
Message-ID: <4070910E.7020808@lycos.com>
Date: Sun, 04 Apr 2004 18:49:50 -0400
From: James Vega <vega_james@lycos.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fat32 all upper-case filename problem
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB44E88C21043C4623CFA605D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB44E88C21043C4623CFA605D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've run across an interesting problem with creating all upper-case 
files/direcotries on fat32 partitions.  After creating a file in all upper-case, 
I can access it for a short time using either the all upper-case name or the all 
lower-case name.  After a short amount of time (or a umount/mount), I can only 
access the file via the all lower-case name.  I'm currently using kernel 2.6.4, 
but I've been seeing this since at least November of last year.

I've talked to a few people to see if anyone else can reproduce this and so far, 
I'm the only one that has been able to (save for the person that reported this 
bug http://bugs.xiph.org/show_bug.cgi?id=413).  Please CC any replies to me as I 
am not subscribed to the list.

Thanks,
James Vega

Example:

debil% touch /usbdrive/CASE
debil% ls /usbdrive
case
debil% ls /usbdrive/CASE
/usbdrive/CASE
debil% ls /usbdrive/case
/usbdrive/case
debil% umount /usbdrive && mount /usbdrive
debil% ls /usbdrive/case
/usbdrive/case
debil% ls /usbdrive/CASE
ls: /usbdrive/CASE: No such file or directory

--------------enigB44E88C21043C4623CFA605D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iEYEARECAAYFAkBwkRQACgkQDb3UpmEybUA+lQCdFoWgshGQia0HeGrr2XWOjbGK
BEUAn1OgzGiPb12BfKqhEpDRkT4TUfGs
=2Hco
-----END PGP SIGNATURE-----

--------------enigB44E88C21043C4623CFA605D--
