Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUIWWrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUIWWrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUIWWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:44:16 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.76]:41926 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S267478AbUIWWlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:41:42 -0400
Subject: gen_initramfs_list.sh (was: Re: [PATCH] gen_init_cpio uses
	external file list) [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com, tharbaugh@lnxi.com, klibc@zytor.com
In-Reply-To: <1095372672.19900.72.camel@tubarao>
References: <1095372672.19900.72.camel@tubarao>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EhHOCqhEZ9eMUaTRVxcI"
Date: Fri, 24 Sep 2004 00:40:47 +0200
Message-Id: <1095979247.26445.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EhHOCqhEZ9eMUaTRVxcI
Content-Type: multipart/mixed; boundary="=-fTr67BuJqRpk9QBcQsik"


--=-fTr67BuJqRpk9QBcQsik
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-16 at 16:11 -0600, Thayne Harbaugh wrote:

Hi

>=20
> This patch makes gen_init_cpio generate the initramfs_data.cpio from a
> file which contains a list of entries: file, dir, nod.  I swapped the
> order of filename/location for the file arguments so that it would be
> more uniform with the dir and nod tyes.
>=20

Attached is a simple script to generate a suitable initramfs_list for
use with gen_init_cpio from an external initramfs source directory, that
could be added to scripts/ if anybody thinks its useful and without
issues.  Note the the description at the top of the file might need
some work from somebody more 'literate' than me.

Sample run:

-----
nosferatu linux-2.6.9-rc2-bk7 # ../scripts/gen_initramfs_list.sh /usr/src/i=
nitramfs/src/
dir /bin 755 0 0
file /bin/umount /usr/src/initramfs/src/bin/umount 755 0 0
file /bin/sleep /usr/src/initramfs/src/bin/sleep 755 0 0
file /bin/fstype /usr/src/initramfs/src/bin/fstype 755 0 0
file /bin/chroot /usr/src/initramfs/src/bin/chroot 755 0 0
file /bin/dd /usr/src/initramfs/src/bin/dd 755 0 0
file /bin/minips /usr/src/initramfs/src/bin/minips 755 0 0
file /bin/mkdir /usr/src/initramfs/src/bin/mkdir 755 0 0
file /bin/mount /usr/src/initramfs/src/bin/mount 755 0 0
file /bin/ln /usr/src/initramfs/src/bin/ln 755 0 0
file /bin/true /usr/src/initramfs/src/bin/true 755 0 0
file /bin/sh /usr/src/initramfs/src/bin/sh 755 0 0
file /bin/nuke /usr/src/initramfs/src/bin/nuke 755 0 0
file /bin/mkfifo /usr/src/initramfs/src/bin/mkfifo 755 0 0
file /bin/false /usr/src/initramfs/src/bin/false 755 0 0
file /bin/printf /usr/src/initramfs/src/bin/printf 755 0 0
dir /proc 755 0 0
dir /dev 755 0 0
nod /dev/console 600 0 5 c 5 1
dir /etc 755 0 0
file /etc/dmtab /usr/src/initramfs/src/etc/dmtab 644 0 0
dir /etc/udev 755 0 0
file /etc/udev/udev.conf /usr/src/initramfs/src/etc/udev/udev.conf 644 0 0
dir /etc/udev/rules.d 755 0 0
file /etc/udev/rules.d/30-sda.rules /usr/src/initramfs/src/etc/udev/rules.d=
/30-sda.rules 644 0 0
file /etc/udev/rules.d/40-dm.rules /usr/src/initramfs/src/etc/udev/rules.d/=
40-dm.rules 644 0 0
file /init /usr/src/initramfs/src/init 755 0 0
dir /sbin 755 0 0
file /sbin/run-init /usr/src/initramfs/src/sbin/run-init 755 0 0
file /sbin/dmsetup /usr/src/initramfs/src/sbin/dmsetup 755 0 0
file /sbin/pivot_root /usr/src/initramfs/src/sbin/pivot_root 755 0 0
file /sbin/kpartx /usr/src/initramfs/src/sbin/kpartx 755 0 0
file /sbin/udev /usr/src/initramfs/src/sbin/udev 755 0 0
file /sbin/udevstart /usr/src/initramfs/src/sbin/udevstart 755 0 0
file /sbin/devmap_name /usr/src/initramfs/src/sbin/devmap_name 755 0 0
dir /sys 755 0 0
dir /rootfs 755 0 0
nosferatu linux-2.6.9-rc2-bk7 # ../scripts/gen_initramfs_list.sh /usr/src/i=
nitramfs/src/ > usr/initramfs_list
nosferatu linux-2.6.9-rc2-bk7 #
-----


Regards,

--=20
Martin Schlemmer

--=-fTr67BuJqRpk9QBcQsik
Content-Disposition: attachment; filename=gen_initramfs_list.sh
Content-Type: application/x-shellscript; name=gen_initramfs_list.sh
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKIyBDb3B5cmlnaHQgKEMpIE1hcnRpbiBTY2hsZW1tZXIgPGF6YXJhaEBub3Nm
ZXJhdHUuemEub3JnPgojIFJlbGVhc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTAoj
CiMgQSBzY3JpcHQgdG8gZ2VuZXJhdGUgbmV3bGluZSBzZXBhcmF0ZWQgZW50cmllcyAodG8gc3Rk
b3V0KSBmcm9tIGEgZGlyZWN0b3J5J3MKIyBjb250ZW50cyBzdWl0YWJsZSBmb3IgdXNlIGFzIGEg
Y3Bpb19saXN0IGZvciBnZW5faW5pdF9jcGlvLgojCiMgQXJndWVtZW50czogJDEgLS0gdGhlIHNv
dXJjZSBkaXJlY3RvcnkKIwojIFRPRE86ICBBZGQgc3VwcG9ydCBmb3Igc3ltbGlua3MsIHNvY2tl
dHMgYW5kIHBpcGVzIHdoZW4gZ2VuX2luaXRfY3BpbwojICAgICAgICBzdXBwb3J0cyB0aGVtLgoK
dXNhZ2UoKSB7CgllY2hvICJVc2FnZTogJDAgaW5pdHJhbWZzLXNvdXJjZS1kaXIiCglleGl0IDEK
fQoKc3JjZGlyPSQoZWNobyAiJDEiIHwgc2VkIC1lICdzOi8vKjovOmcnKQoKaWYgWyAiJCMiIC1n
dCAxIC1vICEgLWQgIiR7c3JjZGlyfSIgXTsgdGhlbgoJdXNhZ2UKZmkKCmZpbGV0eXBlKCkgewoJ
bG9jYWwgYXJndjE9IiQxIgoKCWlmIFsgLWYgIiR7YXJndjF9IiBdOyB0aGVuCgkJZWNobyAiZmls
ZSIKCWVsaWYgWyAtZCAiJHthcmd2MX0iIF07IHRoZW4KCQllY2hvICJkaXIiCgllbGlmIFsgLWIg
IiR7YXJndjF9IiAtbyAtYyAiJHthcmd2MX0iIF07IHRoZW4KCQllY2hvICJub2QiCgllbHNlCgkJ
ZWNobyAiaW52YWxpZCIKCWZpCglyZXR1cm4gMAp9CgpwYXJzZSgpIHsKCWxvY2FsIGxvY2F0aW9u
PSIkMSIKCWxvY2FsIG5hbWU9IiR7bG9jYXRpb24vJHtzcmNkaXJ9Ly99IgoJbG9jYWwgbW9kZT0i
JDIiCglsb2NhbCB1aWQ9IiQzIgoJbG9jYWwgZ2lkPSIkNCIKCWxvY2FsIGZ0eXBlPSQoZmlsZXR5
cGUgIiR7bG9jYXRpb259IikKCWxvY2FsIHN0cj0iJHttb2RlfSAke3VpZH0gJHtnaWR9IgoKCVsg
IiR7ZnR5cGV9IiA9PSAiaW52YWxpZCIgXSAmJiByZXR1cm4gMAoJWyAiJHtsb2NhdGlvbn0iID09
ICIke3NyY2Rpcn0iIF0gJiYgcmV0dXJuIDAKCgljYXNlICIke2Z0eXBlfSIgaW4KCQkiZmlsZSIp
CgkJCXN0cj0iJHtmdHlwZX0gJHtuYW1lfSAke2xvY2F0aW9ufSAke3N0cn0iCgkJCTs7CgkJIm5v
ZCIpCgkJCWxvY2FsIGRldl90eXBlPQoJCQlsb2NhbCBtYWo9JChMQ19BTEw9QyBscyAtbCAiJHts
b2NhdGlvbn0iIHwgXAoJCQkJCWdhd2sgJ3tzdWIoLywvLCAiIiwgJDUpOyBwcmludCAkNX0nKQoJ
CQlsb2NhbCBtaW49JChMQ19BTEw9QyBscyAtbCAiJHtsb2NhdGlvbn0iIHwgXAoJCQkJCWdhd2sg
J3twcmludCAkNn0nKQoJCQkKCQkJaWYgWyAtYiAiJHtsb2NhdGlvbn0iIF07IHRoZW4KCQkJCWRl
dl90eXBlPSJiIgoJCQllbHNlCgkJCQlkZXZfdHlwZT0iYyIKCQkJZmkKCQkJc3RyPSIke2Z0eXBl
fSAke25hbWV9ICR7c3RyfSAke2Rldl90eXBlfSAke21han0gJHttaW59IgoJCQk7OwoJCSopCgkJ
CXN0cj0iJHtmdHlwZX0gJHtuYW1lfSAke3N0cn0iCgkJCTs7Cgllc2FjCgoJZWNobyAiJHtzdHJ9
IgoKCXJldHVybiAwCn0KCmZpbmQgIiR7c3JjZGlyfSIgLXByaW50ZiAiJXAgJW0gJVUgJUdcbiIg
fCBcCndoaWxlIHJlYWQgeDsgZG8KCXBhcnNlICR7eH0KZG9uZQoKZXhpdCAwCg==


--=-fTr67BuJqRpk9QBcQsik--

--=-EhHOCqhEZ9eMUaTRVxcI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBU1DvqburzKaJYLYRArhzAJ0Qu7PtUxw3jkdRva3/GF1EyzYa9ACfTuvH
LbsBzecNTMofJcFvsfJ1IqA=
=H2z1
-----END PGP SIGNATURE-----

--=-EhHOCqhEZ9eMUaTRVxcI--

