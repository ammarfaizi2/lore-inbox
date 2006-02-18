Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWBRR32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWBRR32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWBRR31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:29:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12704 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932097AbWBRR31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:29:27 -0500
Date: Sat, 18 Feb 2006 18:29:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060218172908.GD1776@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <20060217210445.GR3490@openzaurus.ucw.cz> <43F74C89.1080606@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F74C89.1080606@cfl.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 18-02-06 11:34:17, Phillip Susi wrote:
> Pavel Machek wrote:
> >You are missing this. In 1st case, no data is actually lost, because of
> >sync in suspend code;
> >while second case is "goodbye, filesystem".
> 
> Provided that you sync before suspending, and there are no open files on 
> the filesystem, then yes, no data will be lost.  If there are open files 
> on the fs, such as a half saved document, or a running binary, or say, 
> the whole root fs, then you're going to loose data and even panic the 
> kernel, sync or no sync.  From the user perspective, this is
>unacceptable.

While with your solution, you do not loose one open file, you loose
whole filesystem. Which is unacceptable.

> Why should the user give up such functionality just because the 
> connection to the drive thy are using is USB?  Every other type of drive 
> and interface does not suffer from this problem.

Because it is okay to unplug usb disk on runtime, while it is not okay
to unplug ATA disk on runtime. And because alternatives suck even more.

> Maybe Linux should take a page from windows' playbook here.  I believe 
> windows handles this scenario with a USB drive the same way it does when 
> you eject a floppy and reinsert it.  The driver detects that the 
> media/drive _may_ have changed and so it fails requests from the 
> filesystem with an error code indicating this.  The filesystem then sets 
> an override flag so it can send down some reads to verify the media. 
> Generally the FS reads the super block and compares it with the in 
> memory one to make sure it appears to be the same media, and if so, 
> continues normal access without data loss.

Feel free to implement that.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
