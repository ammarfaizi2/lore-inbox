Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVBKBIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVBKBIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 20:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVBKBIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 20:08:37 -0500
Received: from downeast.net ([204.176.212.2]:2792 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261990AbVBKBHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 20:07:49 -0500
Message-ID: <420C054B.1070502@downeast.net>
Date: Thu, 10 Feb 2005 20:07:23 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
References: <20050211004033.GA26624@suse.de>
In-Reply-To: <20050211004033.GA26624@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I'd like to announce, yet-another-hotplug based userspace project:
> linux-ng.  This collection of code replaces the existing linux-hotplug
> package with very tiny, compiled executable programs, instead of the
> existing bash scripts.
> 
> It currently provides the following:
> 	- a /sbin/hotplug multiplexer.  Works identical to the existing
> 	  bash /sbin/hotplug.
> 	- autoload programs for usb, scsi, and pci modules.  These
> 	  programs determine what module needs to be loaded when the
> 	  kernel emits a hotplug event for these types of devices.  This
> 	  works just like the existing linux-hotplug scripts, with a few
> 	  exceptions.
> 
> But why redo this all in .c code?  What's wrong with shell scripts?
> Nothing is wrong with shell scripts, unless you don't want to have an
> interpreter in your initramfs/initrd and you want to provide
> /sbin/hotplug and autoload module functionality.  Or if you have a huge
> box that spawns a zillion hotplug events all at once, and you need to be
> able to handle all of that with the minimum amount of processing time
> and memory.

Wow, thats pretty awesome. Just the other day I said, "Why is hotplug written 
in sh? Isn't that horribly inefficient way of handling something that needs to 
be done quickly using the least amount of resources possible?" It seems you 
were reading my mind.

Please, continue this project and encourage distros to switch to it (when it 
exceeds hotplug in functionality and stability). Ubuntu currently is trying to 
reduce boot time, and I bet something like this would factor in (even a few 
seconds helps).

-- 
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
