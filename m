Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTIYV2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTIYV2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:28:16 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:48330 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261892AbTIYV2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:28:15 -0400
Subject: Tracking remap_page_range error
From: JDeas <jdeas@jadsystems.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1064525484.2372.14.camel@HD1>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 25 Sep 2003 14:31:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What tools can I use to track a error with remap_page_range?
I am working on a driver that remaps a 64M chunk from a
PCI card. I have confirmed that the driver executes

remap_page_range(42133000,f0000000,400000,27)
vma->Flags = 840fb
in the driver mmap. This is driven from my apps mmap
command where I pass NULL for the address.

While the application has the driver open
/proc/[ps]/maps shows the following

42133000-46133000 rw-s 000000


I have also checked /proc/iomem and found
f0000000-f3ffffff
listed on the PCI card I am working on

MY problem is a single write to 42133000 in the application
locks the system and is appearing to try and write to the
vga cards memory (or the crash is affecting the vga screen mem).

What other tools can I use to check/trace this remapping?

Redhat9.0 (2.4.20-6smp) (mem=768 passed to stay under 1G)
PCI card uses Xilinx PCI core

Thanks 
JDeas



