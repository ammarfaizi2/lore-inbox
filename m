Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUAGXTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUAGXTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:19:51 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37388 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262707AbUAGXTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:19:49 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: can't mount encrypted dvd with 2.6.0
Date: 7 Jan 2004 23:07:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bti3g1$7lt$1@gatekeeper.tmr.com>
References: <20040107151948.4376d881@kyp.intra>
X-Trace: gatekeeper.tmr.com 1073516865 7869 192.168.12.62 (7 Jan 2004 23:07:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040107151948.4376d881@kyp.intra>,
Thomas Fischbach  <webmaster@kennygno.net> wrote:

| if I create an encrypted iso image:
| dd if=/dev/zero of=/files/image.iso bs=512 count=$((1024*4400))
| losetup -e aes -k 256 /dev/loop1 /files/image.iso
| mkisofs -r -o /dev/loop1 /files/stuff/*
===> try adding -pad here
| losetup -d /dev/loop1 
| 
| I can mount the file:
| mount /files/image.iso /mnt/cd -t iso9660 \
| -o loop=/dev/loop1,encryption=aes,keybits=256
| 
| but when I burned the iso and tried to mount, it failed with:
| mount: wrong fs type ...
| 
| and the logs says:
| hdc: cdrom_read_intr: data underrun (2 blocks)
| end_request: I/O error, dev hdc, sector 64
| isofs_fill_super: bread failed, dev=loop0, iso_blknum=16, block=32
| 
| under 2.4.22 it works fine.
| Hope someone can help.
| 
| Thanks,
| Thomas
| 
| -- 
| Thomas Fischbach
| http://www.kennygno.net
| webmaster@kennygno.net
| 
| --Signature=_Wed__7_Jan_2004_15_19_48_+0100_UU_WVzZfteNnYfSx
| Content-Type: application/pgp-signature
| 
| -----BEGIN PGP SIGNATURE-----
| Version: GnuPG v1.2.4 (GNU/Linux)
| 
| iD8DBQE//BWEhty018ANwB4RAqbXAJ9qkmHhf18jcEyWS50Tls3Z5lR9/gCePi2G
| 7N2+AScX45pxWJlouVL8+AQ=
| =I4ry
| -----END PGP SIGNATURE-----
| 
| --Signature=_Wed__7_Jan_2004_15_19_48_+0100_UU_WVzZfteNnYfSx--
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
