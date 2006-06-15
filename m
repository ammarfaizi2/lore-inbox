Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031387AbWFOVRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031387AbWFOVRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031416AbWFOVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 17:17:43 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:12699 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1031387AbWFOVRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 17:17:43 -0400
Mime-Version: 1.0
Message-Id: <a0623094bc0b77aaeba9a@[129.98.90.227]>
Date: Thu, 15 Jun 2006 17:17:32 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: The "Out of IOMMU space" error and the "Please enable the IOMMU
 option" option
Cc: ak@suse.de
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally,  we get errors like these:

Jun  9 00:56:35 [kernel] [18020.416620] PCI-DMA: Out of IOMMU space 
for 12288 bytes at device 0000:03:01.0

and it looks like it might have something to do with these messages 
(after updating and setting BIOS as below):

Jun 15 16:38:54 [kernel] [    0.000000] Checking aperture...
Jun 15 16:38:54 [kernel] [    0.000000] CPU 0: aperture @ 0 size 256 MB
Jun 15 16:38:54 [kernel] [    0.000000] No AGP bridge found
Jun 15 16:38:54 [kernel] [    0.000000] Your BIOS doesn't leave a 
aperture memory hole
Jun 15 16:38:54 [kernel] [    0.000000] Please enable the IOMMU 
option in the BIOS setup
Jun 15 16:38:54 [kernel] [    0.000000] This costs you 64 MB of RAM
Jun 15 16:38:54 [kernel] [    0.000000] Mapping aperture over 65536 
KB of RAM @ 8000000

The box is a dual Opteron 250 with an Arima HDAMA Rev. D motherboard.

The updated BIOS options are (with * for current setting)
MTRR mapping method [Continuous, Discrete*]
Memhole mapping [Software, Hardware*]
4 GB memory hole adjust [Disabled, Manual, Auto*]
4 GB memory hole size [128 MB]
IOMMU [Disabled, Enabled*]
Size [multiple sizes, 256 MB*]

Initially, I was booting kernel 2.6.16.1 with iommu=merge, but the 
above message still occur when I booted without any iommu kernel 
parameters.

First, am I correct to assume that I'm not getting the 256 MB?

Second, is the the case the BIOS is lying?

Third, what could be a workaround to get enough memory for the PCI 
card that causes the out of space error (3Ware 8506)?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
