Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUDOUjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUDOUjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:39:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50566 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262309AbUDOUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:39:20 -0400
Date: Thu, 15 Apr 2004 16:02:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Chris Lalancette <chris.lalancette@gd-ais.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory image save/restore
Message-ID: <20040415140225.GN468@openzaurus.ucw.cz>
References: <407C18D0.9010302@gd-ais.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407C18D0.9010302@gd-ais.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    I have been trying to implement some sort of save/restore kernel 
> memory image for the linux kernel (x86 only right now), without much 
> success.  Let me explain the situation:
> 
> I have a hardware device that I can generate interrupts with.  I also 
> have a machine with 512M of memory, and I am passing the kernel the 
> command line mem=256M.  My idea is to generate an interrupt with the 
> hardware device, and then inside of the interrupt handler make a copy 
> of the entire contents of RAM into the unused upper 256M of memory; 
> later on, with another interrupt, I would like to restore that 
> previously saved memory image.  This way we can go "back in time", 
> similar to what software suspend is doing, but without as many 
> constraints (i.e. we have a hardware interrupt to work with, we 
> reserved the same amount of physical memory to use, etc.).  Before I 
> went much further, I figured I would ask if anyone on the list has 
> tried this, and if there are any reasons why this is not possible.

As swsusp shows, it definitely is possible...

...if you can live with system unresponsive for few seconds while it
does snapshotting.

Creating "bastardized swsusp" would actually be good way to start.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

