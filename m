Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310440AbSCLGc0>; Tue, 12 Mar 2002 01:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310446AbSCLGcV>; Tue, 12 Mar 2002 01:32:21 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:32009 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310440AbSCLGcG>; Tue, 12 Mar 2002 01:32:06 -0500
Date: Tue, 12 Mar 2002 07:32:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, andersen@codepoet.org,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312073204.B4863@ucw.cz>
In-Reply-To: <3C8D5ECD.6090108@mandrakesoft.com> <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Mar 11, 2002 at 06:19:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 06:19:05PM -0800, Linus Torvalds wrote:

> On Mon, 11 Mar 2002, Jeff Garzik wrote:
> >
> > You have convinced me that unconditional filtering is bad.  But I still
> > think people should be provided the option to filter if they so desire.
> 
> Hey, choice is always good, except if it adds complexity.
> 
> The problem with conditional filtering is that either it is a boot (or
> compile time) option, or it is a dynamic filter.
> 
> If its a dynamic filter, and you don't trust root, what _are_ you going to
> trust? The root program you don't trust might as well be turning the
> filtering off because it wants to be "convenient". And since the only
> programs you really want to filter are _exactly_ the kinds of programs
> that want to avoid filtering, you're just hosed.
> 
> That's my real beef with this whole idiotic parsing thing. Either it is
> fixed (bad, if you don't know what the commands are for all disks) or it
> is trivially overcome in the name of "convenience" (equally bad, since it
> makes the whole thing pointless).

Well, there are uses for the 'dynamic' filter, and it doesn't add too
much complexity. One could be allowing certain commands to be performed
on certain devices by normal users - eg. CD-burning or whatever without
root privileges (I know we're using ide-scsi for the command access
right now ...), and also protecting the oneself from ACPI and the like.
Because ACPI can do IDE commands and does that in a way interfaceable to
a 'taskfile' kernel ioctl. It'd be nice to know a broken ACPI
implementation can't screw up your drive easily through a kernel driver.

-- 
Vojtech Pavlik
SuSE Labs
