Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTIVS3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTIVS3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:29:35 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:58570 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261632AbTIVS3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:29:30 -0400
Date: Mon, 22 Sep 2003 11:29:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: [PATCH] Add 'make uImage' for PPC32
Message-ID: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following BK patch adds support for a 'uImage' target on
PPC32.  This will create an image for the U-Boot (and formerly
PPCBoot) firmware.  The patch adds a scripts/mkuboot.sh as a wrapper for
the U-Boot mkimage program.  We put mkuboot.sh into scripts/ because
U-Boot works on a number of other platforms, and it's likely that they
will add a uImage target at some point.  Please apply.

--
Tom Rini
http://gate.crashing.org/~trini/

This BitKeeper patch contains the following changesets:
trini@kernel.crashing.org|ChangeSet|20030922180348|00070

# ID:	torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
# User:	trini
# Host:	kernel.crashing.org
# Root:	/home/trini/work/kernel/pristine/linux-2.4

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
marcelo@logos.cnet|ChangeSet|20030922093809|51297
D 1.1132 03/09/22 11:03:48-07:00 trini@kernel.crashing.org +5 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c PPC32: Add a 'uImage' target for U-Boot.
K 70
P ChangeSet
------------------------------------------------

0a0
> trini@kernel.crashing.org|scripts/mkuboot.sh|20030922175825|02447|ee487e28b66d94ad trini@kernel.crashing.org|scripts/mkuboot.sh|20030922175826|22966
> patch@plucky.distro.conectiva|arch/ppc/boot/utils/mkimage.wrapper|20020313233104|62933|788151aa6df8c6c5 trini@kernel.crashing.org|BitKeeper/deleted/.del-mkimage.wrapper~788151aa6df8c6c5|20030922175822|19266
> torvalds@athlon.transmeta.com|arch/ppc/Makefile|20020205174025|03176|d061f618f6a9980 trini@kernel.crashing.org|arch/ppc/Makefile|20030922180241|27723
> patch@athlon.transmeta.com|arch/ppc/boot/images/Makefile|20020205182446|07840|d44cf30ff4422294 trini@kernel.crashing.org|arch/ppc/boot/images/Makefile|20030922180241|24193
> torvalds@athlon.transmeta.com|arch/ppc/boot/Makefile|20020205174025|54177|a1ccc61f9b0e318d trini@kernel.crashing.org|arch/ppc/boot/Makefile|20030922180241|43396

== arch/ppc/boot/images/Makefile ==
patch@athlon.transmeta.com|arch/ppc/boot/images/Makefile|20020205182446|07840|d44cf30ff4422294
patch@plucky.distro.conectiva|arch/ppc/boot/images/Makefile|20020313233113|23561
D 1.4 03/09/22 11:02:41-07:00 trini@kernel.crashing.org +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c On clean, remove uImage.
K 24193
O -rw-rw-r--
P arch/ppc/boot/images/Makefile
------------------------------------------------

D12 1
I12 1
	rm -f sImage vmapus vmlinux* miboot* zImage* zvmlinux* uImage

== BitKeeper/deleted/.del-mkimage.wrapper~788151aa6df8c6c5 ==
patch@plucky.distro.conectiva|arch/ppc/boot/utils/mkimage.wrapper|20020313233104|62933|788151aa6df8c6c5
patch@plucky.distro.conectiva|arch/ppc/boot/utils/mkimage.wrapper|20020313233105|23257
D 1.2 03/09/22 10:58:22-07:00 trini@kernel.crashing.org +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Delete: arch/ppc/boot/utils/mkimage.wrapper
K 19266
O -rw-rw-r--
P BitKeeper/deleted/.del-mkimage.wrapper~788151aa6df8c6c5
------------------------------------------------


== arch/ppc/Makefile ==
torvalds@athlon.transmeta.com|arch/ppc/Makefile|20020205174025|03176|d061f618f6a9980
paulus@samba.org|arch/ppc/Makefile|20030828124029|27091
D 1.22 03/09/22 11:02:41-07:00 trini@kernel.crashing.org +1 -1
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Add a uImage target.
K 27723
O -rw-rw-r--
P arch/ppc/Makefile
------------------------------------------------

D88 1
I88 1
BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd uImage

== arch/ppc/boot/Makefile ==
torvalds@athlon.transmeta.com|arch/ppc/boot/Makefile|20020205174025|54177|a1ccc61f9b0e318d
trini@kernel.crashing.org|arch/ppc/boot/Makefile|20030703161526|40255
D 1.11 03/09/22 11:02:41-07:00 trini@kernel.crashing.org +8 -6
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Add a uImage target, which replaces the pImage target.
K 43396
O -rw-rw-r--
P arch/ppc/boot/Makefile
------------------------------------------------

D20 1
I20 1
MKIMAGE				:= $(TOPDIR)/scripts/mkuboot.sh
D64 3
I66 4
# Make an image for PPCBoot / U-Boot.
uImage: images/vmlinux.gz
	$(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T kernel \
	-C gzip -a 00000000 -e 00000000 \
D68 2
I69 3
	-d $< images/vmlinux.UBoot
	ln -sf vmlinux.UBoot images/uImage
	rm -f ./mkuboot

== scripts/mkuboot.sh ==
New file: scripts/mkuboot.sh
V 4

trini@kernel.crashing.org|scripts/mkuboot.sh|20030922175825|02447|ee487e28b66d94ad
D 1.0 03/09/22 10:58:25-07:00 trini@kernel.crashing.org +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
c BitKeeper file /home/trini/work/kernel/pristine/linux-2.4/scripts/mkuboot.sh
K 2447
P scripts/mkuboot.sh
R ee487e28b66d94ad
X 0x821
------------------------------------------------


trini@kernel.crashing.org|scripts/mkuboot.sh|20030922175825|02447|ee487e28b66d94ad
D 1.1 03/09/22 10:58:25-07:00 trini@kernel.crashing.org +16 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
F 1
K 22966
O -rw-rw-r--
P scripts/mkuboot.sh
------------------------------------------------

I0 16
#!/bin/bash
\
#
# Build U-Boot image when `mkimage' tool is available.
#
\
MKIMAGE=$(type -path mkimage)
\
if [ -z "${MKIMAGE}" ]; then
	# Doesn't exist
	echo '"mkimage" command not found - U-Boot images will not be built' >&2
	exit 0;
fi
\
# Call "mkimage" to create U-Boot image
${MKIMAGE} "$@"

# Patch checksum=f21abf61
