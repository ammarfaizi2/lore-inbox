Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVKHRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVKHRHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVKHRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:07:12 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62899 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965000AbVKHRHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:07:10 -0500
Subject: Highpoint IDE types
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 17:38:02 +0000
Message-Id: <1131471483.25192.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok thanks to Sergei I can now post what I think is the complete table of
HPT chip versions:

        Chip                    PCI ID          Rev
 *      HPT366                  4 (HPT366)      0
 *      HPT366                  4 (HPT366)      1    
 *      HPT368                  4 (HPT366)      2      
 *      HPT370                  4 (HPT366)      3      
 *      HPT370A                 4 (HPT366)      4      
 *      HPT372                  4 (HPT366)      5     
 *      HPT372N                 4 (HPT366)      6     
 *      HPT372                  5 (HPT372)      0       
 *      HPT372N                 5 (HPT372)      > 0     
 *      HPT302                  6 (HPT302)      *       
 *      HPT302N                 6 (HPT302)      > 1    
 *      HPT371                  7 (HPT371)      *      
 *      HPT371N                 7 (HPT371)      > 1     
 *      HPT374                  8 (HPT374)      *     
 *      HPT372N                 9 (HPT372N)     *     


The base clocks for the devices are as follows (note this means most of
the drivers/ide/pci detection code for frequency is wrong). Also for PLL
mode the 3x2N PLL stabilization code is subtly different.

371N/372N/302N		77
302/371/372A		66
372			55
370/374			48

The DPLLs are
	48, 50, 66, 75Mhz

75 is only available on the later chips and used with PATA/SATA bridge
chips for UDMA7.


