Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270805AbUJUSwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbUJUSwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270820AbUJUStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:49:52 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:59788 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S270797AbUJUSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:44:51 -0400
Subject: 2.6.9-bk6 initramfs build failure with separate object dir
From: Tom Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org.sun.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+Wdl3qegcXQYeWMmd4AE"
Date: Thu, 21 Oct 2004 11:43:42 -0700
Message-Id: <1098384222.2389.22.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Wdl3qegcXQYeWMmd4AE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


[tduffy@duffman linux-2.6.9-bk-openib]$ make O=3D/build1/tduffy/openib-work=
/build/bk/3.4/x86_64/
  Using /build1/tduffy/openib-work/linux-2.6.9-bk-openib as source for kern=
el
  CHK     include/linux/version.h
make[2]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-x86_64/offset.h
  CHK     include/linux/compile.h
  GEN_INITRAMFS_LIST usr/initramfs_list
Using shipped usr/initramfs_list
  CPIO    usr/initramfs_data.cpio
ERROR: unable to open 'usr/initramfs_list': No such file or directory

Usage:
        ./usr/gen_init_cpio <cpio_list>

<cpio_list> is a file containing newline separated entries that
describe the files to be included in the initramfs archive:

# a comment
file <name> <location> <mode> <uid> <gid>
dir <name> <mode> <uid> <gid>
nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>

<name>      name of the file/dir/nod in the archive
<location>  location of the file in the current filesystem
<mode>      mode/permissions of the file
<uid>       user id (0=3Droot)
<gid>       group id (0=3Droot)
<dev_type>  device type (b=3Dblock, c=3Dcharacter)
<maj>       major number of nod
<min>       minor number of nod

example:
# A simple initramfs
dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
dir /root 0700 0 0
dir /sbin 0755 0 0
file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0
make[2]: *** [usr/initramfs_data.cpio] Error 1
make[1]: *** [usr] Error 2
make: *** [_all] Error 2


--=-+Wdl3qegcXQYeWMmd4AE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBeANedY502zjzwbwRAryZAJ9e2L4NM8o8nrkCCBDs9SCkpDbAtwCdGBWR
SU42WJlwgWM9xVOO+w8de7A=
=ljnm
-----END PGP SIGNATURE-----

--=-+Wdl3qegcXQYeWMmd4AE--
