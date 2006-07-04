Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWGDUXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWGDUXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWGDUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:23:12 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:64972 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932385AbWGDUXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:23:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=YHafxX1l+LahJvPv4VfGysHVIeRd6Cn5kDRUnmHHBCqHSsHD9eAgVP5dOch2Qk+9n2rHRgBhDpN0EdtWo7vfFrMo1dzgRO++WlvgJWQ+QH2G6L3NNKQAhbFOKIx8nfaLsjPTXP2GfVLbHB+Q66HhjHQUKCHq1/ItY53X+/gSC1g=
Message-ID: <44AACE30.3000601@gmail.com>
Date: Tue, 04 Jul 2006 22:23:12 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL][PATCH] include/linux/Kbuild devfs fix
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this error while "make O=/dir headers_install"

sed: can't read /usr/src/linux-git/include/linux/devfs_fs.h: No such file or directory
make[3]: *** [devfs_fs.h] Error 2
make[2]: *** [linux] Error 2
make[1]: *** [headers_install] Error 2
make: *** [headers_install] Error 2

Here is a patch

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

--- linux-git/include/linux/Kbuild2	2006-07-04 22:04:28.000000000 +0200
+++ linux-git/include/linux/Kbuild	2006-07-04 22:13:44.000000000 +0200
@@ -8,7 +8,7 @@ header-y += affs_fs.h affs_hardblocks.h
 	atmppp.h atmsap.h atmsvc.h atm_zatm.h auto_fs4.h auxvec.h	\
 	awe_voice.h ax25.h b1lli.h baycom.h bfs_fs.h blkpg.h		\
 	bpqether.h cdk.h chio.h coda_psdev.h coff.h comstats.h		\
-	consolemap.h cycx_cfm.h devfs_fs.h dm-ioctl.h dn.h dqblk_v1.h	\
+	consolemap.h cycx_cfm.h dm-ioctl.h dn.h dqblk_v1.h	\
 	dqblk_v2.h dqblk_xfs.h efs_fs_sb.h elf-fdpic.h elf.h elf-em.h	\
 	fadvise.h fd.h fdreg.h ftape-header-segment.h ftape-vendors.h	\
 	fuse.h futex.h genetlink.h gen_stats.h gigaset_dev.h hdsmart.h	\
