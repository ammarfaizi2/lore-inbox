Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVBUOFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVBUOFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVBUOFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:05:51 -0500
Received: from aveo.vortech.net ([206.183.8.5]:29379 "EHLO aveo.vortech.net")
	by vger.kernel.org with ESMTP id S261980AbVBUOFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:05:46 -0500
From: Joshua Jackson <jjackson@vortech.net>
Organization: Vortech Consulting
To: linux-kernel@vger.kernel.org
Subject: Promise sx6000 patch help
Date: Mon, 21 Feb 2005 09:04:39 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502210904.39298.jjackson@vortech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have spent a bit of time to try to port the Linux 2.4 based Promise SX6000 
ATA RAID controller driver to the 2.6 kernels but have gotten myself stuck.

I know very little about writing Linux SCSI drivers and have obviously done 
something very wrong. The drive compiles, loads, detects the controller and 
even the arrays attached to the controller but hangs the system (hard - no 
keyboard, mouse, etc response) 5-10 seconds after loading.

I am quite suspicious of the scatter gather mappings (again, something I have 
no experience with). The original driver also uses kmalloc to allocate its 
DMA buffers. I have read a bit about pci_allocate_consistent, but do not know 
how to properly use the virtual and physical addresses returned.

The following patch is against a stock 2.6.10 kernel. All of the files 
associated with the driver get placed in drivers/scsi/sx6000/

http://www.vortech.net/~jjackson/pti-sx6000.patch.gz

Any help in getting this driver functioning would be greatly appreciated. 

-- 
Joshua Jackson
Vortech Consulting
http://www.vortech.net
