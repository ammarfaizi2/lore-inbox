Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWG0O1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWG0O1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWG0O1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:27:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46091 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932137AbWG0O1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:27:39 -0400
Date: Thu, 27 Jul 2006 10:27:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andy Chittenden <AChittenden@bluearc.com>
cc: Andrew Morton <akpm@osdl.org>, <david-b@pacbell.net>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] 2.6.17 hangs during boot on ASUS M2NPV-VM
 motherboard
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270464D07C@uk-email.terastack.bluearc.com>
Message-ID: <Pine.LNX.4.44L0.0607271023550.6315-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Andy Chittenden wrote:

> > So why did putting in the initial lot of debug alter where 
> > the kernel hung? And what's next?

I don't know why the location of the hang changed.  It suggests you're up 
against some kind of race against the hardware.

The new location you found is in the driver core, and a bug was fixed in 
that region just about at the same time as you ran your test.  You might 
try redoing everything with the current -mm tree plus hotfixes.

And try running each test a few times.  If there is a race, you could get 
different results each time.

Alan Stern

