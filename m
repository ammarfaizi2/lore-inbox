Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTKIUon (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 15:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTKIUon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 15:44:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59409 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262794AbTKIUol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 15:44:41 -0500
Date: Sun, 9 Nov 2003 15:44:40 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: How to allocate pages for a scatter-gather buffer?
Message-ID: <Pine.LNX.4.44L0.0311091533520.23369-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens:

Thanks for your help in tracking down that problem with the usb-storage 
sddr09 driver.

Now a slightly different question.  Suppose I want to allocate some pages
as a scatter-gather buffer for I/O to a device.  I've got the device's
dma_mask; what's the right way to convert that to a GFP bitmask for
alloc_pages() or get_free_pages()?

Also, assuming I'll have to use memcpy() to transfer data into or out of 
the scatter-gather buffer (so it will have to get a kernel virtual mapping 
at some point), am I better off using alloc_pages() followed by 
kmap_atomic()/kunmap_atomic() or get_free_pages()?  Or even kmalloc()?

Alan Stern

