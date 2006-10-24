Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWJXOJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWJXOJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWJXOJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:09:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:29201 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030337AbWJXOJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:09:06 -0400
Date: Tue, 24 Oct 2006 10:09:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M"
 from card reader
In-Reply-To: <453DE80E.8090607@aitel.hist.no>
Message-ID: <Pine.LNX.4.44L0.0610241006160.6426-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Helge Hafting wrote:

> I just tested this. 2.6.18 does not crash. I still get tons of errors,
> and no data. Copying using 1MB chunks or 4kB chunks
> don't matter, it doesn't work.  So card, reader or driver must be faulty.
> The card works in a windows machine though.
> 
> 2.6.19-rc1 gets data with 4kB chunks, and BUGs with 1M chunks.

It would be interesting to compare 2.6.18 with 2.6.19-rc to see why the 
first gets only errors while the second is able to transfer some data 
using 4 KB chunks.

(By the way, what do you mean by 4 KB chunks or 1 MB chunks?  Does this 
refer to the bs= option for dd?  That has almost nothing to do with the 
size of the transfers actually sent to the device.)

But the log will be useless unless you turn on CONFIG_USB_STORAGE_DEBUG.

Alan Stern

