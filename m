Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWBMAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWBMAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWBMAv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:51:26 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:27287 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751077AbWBMAvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:51:25 -0500
Message-ID: <43EFD806.3000904@cfl.rr.com>
Date: Sun, 12 Feb 2006 19:51:18 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602121147040.9971-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602121147040.9971-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Both of you are missing an important difference between Suspend-to-RAM and 
> Suspend-to-Disk.
> 
> Suspend-to-RAM is a true suspend operation, in that the hardware's state
> is maintained _in the hardware_.  External buses like USB will retain
> suspend power, for instance (assuming the motherboard supports it; some
> don't).
> 
> Suspend-to-Disk, by contrast, is _not_ a true suspend.  It can more 
> accurately be described as checkpoint-and-turn-off.  Hardware state is not 
> maintained.  (Some systems may support a special ACPI state that does 
> maintain suspend power to external buses during shutdown, I forget what 
> it's called.  And I down't know whether swsusp uses this state.)
> 

I would disagree.  The only difference between the two is WHERE the 
state is maintained - ram vs. disk.  I won't really argue it though, 
because it's just semantics -- call it whatever you want.

> So for example, let's say you have a filesystem mounted on a USB flash or
> disk drive.  With Suspend-to-RAM, there's a very good chance that the
> connection and filesystem will still be intact when you resume.  With
> Suspend-to-Disk, the USB connection will terminate when the computer shuts
> down.  When you resume, the device will be gone and your filesystem will
> be screwed.
> 

This is not true.  The USB bus is shut down either way, and provided 
that you have not unplugged the disk, nothing will be screwed when you 
resume from disk or ram.


