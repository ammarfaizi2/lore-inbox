Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTENA2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbTENA2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:28:04 -0400
Received: from dsl-213-023-064-103.arcor-ip.net ([213.23.64.103]:30653 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP id S262139AbTENA2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:28:03 -0400
Date: Wed, 14 May 2003 02:40:09 +0200
From: axel@pearbough.net
To: linux-kernel@vger.kernel.org
Subject: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514004009.GA20914@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

today compiled 2.5.69-bk8 with gcc version 3.3 20030510 and a warning in
drivers/scsi/aic7xxx/aic7xxx_osm.c resulted in an error because of gcc flag
-Werror.

  gcc -Wp,-MD,drivers/scsi/aic7xxx/.aic7xxx_osm.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i586
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
include  -Idrivers/scsi -Werror  -DKBUILD_BASENAME=aic7xxx_osm
-DKBUILD_MODNAME=aic7xxx -c -o drivers/scsi/aic7xxx/aic7xxx_osm.o
drivers/scsi/aic7xxx/aic7xxx_osm.c
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_map_seg':
drivers/scsi/aic7xxx/aic7xxx_osm.c:767: warning: integer constant is too
large for "long" type
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_osm.o] Error 1


regards,
axel siebenwirth
