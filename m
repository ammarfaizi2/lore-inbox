Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbTHGUBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270461AbTHGUBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:01:43 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:44720
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S270458AbTHGUBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:01:42 -0400
Date: Thu, 7 Aug 2003 21:01:40 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.22-rc1 breaks dri in X-4.3.0
Message-ID: <Pine.LNX.4.56.0308072050120.9400@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Apologies if this is a known bug, I'm slightly lost following the list,
and the only bug I can see mentioned seems to be in Alan's tree.

 I've just built 2.4.22-rc1 for my PIII (via chipset, radeon 7500), and
rebuilt radeon.o from the X 4.3 release.  This combination worked with
2.4.22-pre7 (although with occasional X lock-ups).

 In X's log I can see that the radeon module fails to open
/dev/dri/card0 (no such device) and therefore the module load fails.

 From dmesg I can see that agpgart detects the chipset and reports the
aperture,  but there are zero [drm] messages following.

My .config shows

CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m

Ken
-- 
 Peace, love, linux



