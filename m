Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUINPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUINPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269441AbUINPli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:41:38 -0400
Received: from sd291.sivit.org ([194.146.225.122]:30372 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S269437AbUINPjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:39:23 -0400
Date: Tue, 14 Sep 2004 17:39:18 +0200
From: Luc Saillard <luc@saillard.org>
To: Linux USB List <linux-usb-devel@lists.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PWC driver without binary interface
Message-ID: <20040914153918.GA7975@sd291.sivit.org>
Mail-Followup-To: Linux USB List <linux-usb-devel@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I've made a patch to (re)add pwc philips driver into the kernel. This driver
have support for some compression mode (for chipset 2 & 3), so you don't
need the binary module to grab an image in 640x480@10fps.
Use this driver with caution, i've test on several webcam (type 730, 740).
Mode bayer is not implemented, the camera only output yuv420p (planar mode).
Future plan is to improve compatibility with other webcam, and try to
implement decoder for version 1.

 As wish by the original author, i've remove email address for the support, and
add a disclaimer "this is unofficial version".

 The patch is 300kbytes long, i don't include it in this mail. You can found
 a tarball or a patch against the last linux kernel at:
    http://www.saillard.org/pwc/linux-2.6.9-rc2_pwc-9.0.2-fork0.2.diff.bz2
    http://www.saillard.org/pwc/
 
diffstat linux-2.6.9-rc2_pwc-9.0.2-luc0.diff
 Kconfig              |   36 
 Makefile             |    1 
 pwc/ChangeLog        |  143 +++
 pwc/Makefile         |   20 
 pwc/philips.txt      |  236 +++++
 pwc/pwc-ctrl.c       | 1630 +++++++++++++++++++++++++++++++++++++
 pwc/pwc-dec1.c       |   42 
 pwc/pwc-dec1.h       |   36 
 pwc/pwc-dec23.c      |  628 ++++++++++++++
 pwc/pwc-dec23.h      |   58 +
 pwc/pwc-if.c         | 2209 +++++++++++++++++++++++++++++++++++++++++++++++++++
 pwc/pwc-ioctl.h      |  292 ++++++
 pwc/pwc-kiara.c      |  875 ++++++++++++++++++++
 pwc/pwc-kiara.h      |   45 +
 pwc/pwc-misc.c       |  140 +++
 pwc/pwc-nala.h       |   66 +
 pwc/pwc-timon.c      | 1344 +++++++++++++++++++++++++++++++
 pwc/pwc-timon.h      |   61 +
 pwc/pwc-uncompress.c |  147 +++
 pwc/pwc-uncompress.h |   41 
 pwc/pwc.h            |  278 ++++++
 21 files changed, 8328 insertions(+)

Please comment about the patch, or help me to find better variables name.

Luc

