Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWBNPdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWBNPdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWBNPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:33:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59526 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161069AbWBNPdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:33:11 -0500
Date: Tue, 14 Feb 2006 10:33:10 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <9F9173CE-E059-433B-98AD-91084823AFDD@mac.com>
Message-ID: <Pine.LNX.4.44L0.0602141025480.5104-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Kyle Moffett wrote:

> For the software-suspend/no-low-power-mode case, I see a couple of  
> practical and spec-conforming options:
> 
> 1)  The kernel should notice that it has a filesystem mounted from a  
> hotpluggable block device and abort the suspend process.  This isn't  
> terribly user friendly, but is guaranteed to prevent data loss, and a  
> good set of suspend scripts could notice the reason for failure and  
> report it to the user (optionally unmounting the filesystems  
> automatically and retrying).
...

There are some difficulties connected with these suggestions.  They're
maybe not impossible, but it would be tricky.

For one thing, how does one go about telling at the USB level whether one
of the devices contains a mounted filesystem?  Or any open file references
at all, for that matter?  No doubt there's a way to do it, but I don't
know what it is.

For another, hardware behavior is very idiosyncratic.  It's sometimes 
possible to tell that a particular system doesn't supply suspend power to 
a USB controller (because, for instance, the controller doesn't support 
PCI PM or doesn't support D3hot), but this is far from reliable -- I've 
seen mistakes both ways.  It's not as simple as "power available during 
STR, not available during STD".

Alan Stern

