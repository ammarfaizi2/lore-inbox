Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWBBVMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWBBVMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWBBVMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:12:23 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:37518 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751193AbWBBVMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:12:22 -0500
Date: Thu, 2 Feb 2006 16:12:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Question about memory barriers
Message-ID: <Pine.LNX.4.44L0.0602021607100.5016-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel's documentation about memory barriers is rather skimpy.  I 
gather that rmb() guarantees that all preceding reads will have completed 
before any following reads are made, and wmb() guarantees that all 
preceding writes will have completed before any following writes are made.  
I also gather that mb() is essentially the same as rmb() and wmb() put 
together.

But suppose I need to prevent a read from being moved past a write?  It 
doesn't look like either rmb() or wmb() will do this.  And if mb() is the 
same as "rmb(); wmb();" then it won't either.  So what's the right thing 
to do?

Alan Stern

