Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVEaRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVEaRnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVEaRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:43:49 -0400
Received: from atpro.com ([12.161.0.3]:23556 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261163AbVEaRnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:43:46 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 31 May 2005 13:14:44 -0400
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: Q: swsusp with S5 instead of S4?
Message-ID: <20050531171444.GC17338@voodoo>
Mail-Followup-To: "Ian E. Morgan" <imorgan@webcon.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	pavel@suse.cz
References: <Pine.LNX.4.62.0505021701090.14807@light.int.webcon.net> <20050530234820.GR28288@voodoo> <Pine.LNX.4.62.0505311027410.20470@light.int.webcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505311027410.20470@light.int.webcon.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/05 10:35:56AM -0400, Ian E. Morgan wrote:
> On Mon, 30 May 2005, Jim Crilly wrote:
> 
> >On 05/02/05 05:13:15PM -0400, Ian E. Morgan wrote:
> >>However, some of the ancilary functions, such as LCD brightness, RF kill
> >>switch, and volume mute button do not work after resuming.
> >
> >I had a similar issue in that the power button wouldn't issue any acpi
> >events after resuming. The solution was to simply remove the acpi button
> >module before suspend and reload it after resume. If you can figure out
> >which modules drive the functions that aren't working for you the same
> >might be possible.
> 
> Unfortunately the LCD/Wifi buttons seem to be managed directly by the
> hardware/BIOS. They do not generate input or ACPI events. I have no problem
> with the power button or lid generating acpi events.
> 
> My best idea at one point was to figure out some way to reset the keyboard
> driver, but I don't know how. In theory I could modularize the whole
> serio/keyboard system etc, but then I would have no way to unload/reload the
> necessary modules without some other form of input, like over a network
> connection. I might try that anyways just as an exercise in futility.

Well if you use the swsusp2 hibernate script, you can have it unload,
reload modules or just run whatever scripts you want if you need to do
something more. The hibernate script was written for swsusp2 but you can
configure it to use swsusp instead really easily.

> 
> >Note that I was using swsusp2 and not the in-kernel swsusp, but I doubt
> >that would make a difference.
> 
> I tried suspend2 on a lark, but could not get it to work.. always complained
> about not being able to allocate enough pages for the image.. which was
> clearly bull.. but who knows. Google didn't turn up much.

If you're using reiserfs for your rootfs that's probably the problem, AFAIK
that's being worked on but I haven't paid much attention to the issue since
i don't use reiserfs and the only swsusp2 problem I've had were nVidia
related.

> 
> Thanks for your input, Jim.
> 
> Regards,
> Ian Morgan

Jim.
