Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314202AbSDQXgD>; Wed, 17 Apr 2002 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314201AbSDQXgC>; Wed, 17 Apr 2002 19:36:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314202AbSDQXgB>; Wed, 17 Apr 2002 19:36:01 -0400
Subject: Re: 1 Terabyte+ Disk Support?
To: mrdobalina@hotmail.com (bob dobalina)
Date: Thu, 18 Apr 2002 00:54:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F50W2lSYgCSrlrCv3wB00016f23@hotmail.com> from "bob dobalina" at Apr 17, 2002 05:39:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xzFV-0003Pc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.2.14-5 Kernel that comes standard with Redhat Linux 6.2. I am trying to 
> determine the best way to patch a pile of Redhat 6.2 (zoot)systems to 
> recognize 1Terabyte and larger disks. I am trying to directly attach 
> 1.5Terabyte (external) RAID arrays to these Redhat 6.2 systems via Ultra160 
> SCSI adapters.

Split them into two arrays

> The cut-off point for large disks in Redhat 6.2 and 7.2 appears to be around 
> 900 Gigabytes, I can get both Redhat 6.2 and 7.2 to see up to around 900 
> gigs as 1 disk. I've heard about a 64-bit IO patch for an older 2.x.x 'pre8' 
> release kernel but would like to know if theres a way to get this 
> accomplished with Redhat 6.2/Kernel 2.2.14-5. Any insight into this problem 
> would be greatly appreciated!

Passing 1Tb wraps the block number in 32bit space. Fixing that to 2Tb has
been done and verified for a few controllers (Leonard Zubkoff did some 
work on that) for current 2.4. Doing it "right" is a 2.5 project.
