Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVJDNwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVJDNwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVJDNwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:52:46 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31646 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932427AbVJDNwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:52:46 -0400
Date: Tue, 4 Oct 2005 09:52:45 -0400
To: Jan Knutar <jk-lkml@sci.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writer is burning with open tray
Message-ID: <20051004135245.GS7949@csclub.uwaterloo.ca>
References: <20050929141924.GA6512@kestrel> <20050929162836.GA20178@csclub.uwaterloo.ca> <200510040216.36796.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510040216.36796.jk-lkml@sci.fi>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 02:16:36AM +0300, Jan Knutar wrote:
> Actually that is not quite true under Linux in all circumstances. There seems
> to be no way to interrupt a mount attempt under Linux. I've sent a kill -9 to
> the mount process, went to bed, and it was still attempting to read the disc
> when I woke up 8 hours later. I'm not sure if it was due to bad firmware, or
> due to Linux retrying failed read requests too many times. Somehow I would
> except though, that sending kill -9 to the process in question would also try
> abort the pending request rather than retrying it indefinitely.
> Ejecting the disc with needle in emergency eject hole always made Linux give up
> and mount fail, though, luckily saving me from reboot.

If your drive needs a forced eject to interrupt it's firmware from
trying to read a disc, it has problems.

> It's even worse on IDE where it can block all devices on the same channel, then
> you have some pages on another device on same channel which are needed in
> order to execute kill -9 or advance the cursor in your xterm :) Then you don't even
> have choice of trying a kill -9 first...
> Call me impatient, I usually give it a day or two after ^C and kill -9 before I resort
> to emergency eject on the drive. I had a system once where even that didn't unwedge
> things, I had to unplug the power from the IDE device in question before things unlocked.
> Sure, it resulted in lots of nasty messages in dmesg and in the smartd log on the other
> device on same IDE channel, but no data corruption luckily.

I find that mounting a cdrom will either suceed or fail within a few
minutes on any hardware I have ever bought.  My hardware seems to tell
the OS that it can't read the disc.  I have seen cheap drives that
seemed to just keep trying forever and were essentially unable to be
interrupted.  I don't buy that kind of hardware.

Check if your drive firmware is actually up to date.  If not, update it.
Maybe the company making the drive has fixed their mistakes.

Len Sorensen
