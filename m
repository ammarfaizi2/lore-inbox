Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWBNE2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWBNE2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWBNE23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:28:29 -0500
Received: from mx1.rowland.org ([192.131.102.7]:11536 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750962AbWBNE23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:28:29 -0500
Date: Mon, 13 Feb 2006 23:28:27 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com>
Message-ID: <Pine.LNX.4.44L0.0602132317530.20628-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Kyle Moffett wrote:

> Which causes worse data-loss, writing out cached pages and filesystem  
> metadata to a filesystem that has changed in the mean-time (possibly  
> allocating those for metadata, etc) or forcibly unmounting it as  
> though the user pulled the cable?  Most filesystems are designed to  
> handle the latter (it's the same as a hard-shutdown), whereas _none_  
> are designed to handle the former.

That's a good point.  Furthermore, any decent suspend script will flush
all dirty buffers to disk before suspending anything.

> A good set of suspend scripts should handle the hardware-suspend with  
> no extra work because hardware supporting hardware-suspend basically  
> inevitably supports USB low-power-mode,

Unfortunately a lot of hardware doesn't support USB low-power mode.  I 
guess you'd say therefore it doesn't really support hardware-suspend.  
This may be so, but it's small comfort to the owners of those systems.

I have to admit, although technically Phillip's argument is wrong, from a
useability standpoint it is right.  Windows allows users to disconnect and
reconnect USB storage devices while the system is hibernating, with no
apparent ill effects -- although I've never tried to unplug one device and
then plug in a different one on the same port while the computer was
asleep.  I don't know to what extent Windows checks descriptors/serial 
numbers/disk labels/whatever when it wakes up.

Alan Stern

