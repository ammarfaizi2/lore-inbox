Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUDDLVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUDDLVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 07:21:51 -0400
Received: from [80.72.36.106] ([80.72.36.106]:64454 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262322AbUDDLVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 07:21:22 -0400
Date: Sun, 4 Apr 2004 13:21:13 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.[45]-.*: weird behavior
In-Reply-To: <200404040109.13414.rjwysocki@sisk.pl>
Message-ID: <Pine.LNX.4.58.0404041248400.7155@alpha.polcom.net>
References: <200404032122.54823.rjwysocki@sisk.pl> <200404032314.27866.rjwysocki@sisk.pl>
 <Pine.LNX.4.58.0404032341450.18910@alpha.polcom.net> <200404040109.13414.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe you should check IRQ sharing with ps port (if it is ps keyboard). Is 
it different under >=2.6.4-mm than under other kernels?

And maybe you should add boot options to turn ACPI and other similar 
options off.

And what video card are you using? There were some problems with S3 and 
other cards / XFree86 implementations in the past. Maybe kernel change is 
just exposing the problemm, not producing it? What about starting X with 
vesa or other "generic" driver insead of driver for your card.

I tried hard to reproduce your problem on my Athlon 32 box with 
2.6.5-rc3-mm4 but with no luck. I have some problems with this kernel, as 
with other kernels past 2.6.4 (for example I cannot mount any non root non 
virtual fs :)), but not this kind of problem. If I remember good I had one 
keyboard lockup under X in last month, but this was on 2.6.2-rc2-mm? 
kernel (probalby) after exiting from game (aa) and keyboard did not 
unlock (but I didint wait 30 sec - I do not have enough amount of 
patience :)). This problem never happened again.

What are exact steps to reproduce your problem?

And maybe the common thing with these two configurations is the 
SMP<->preemprion. These two are very similar in producing problems and if 
I remember good you have preemtion enabled on the laptop. Can you 
reproduce the problem without it?

I also found the patch for kernel stack in proc - it is here:

  http://thebsh.namesys.com/snapshots/LATEST/extra/a_04-proc-stack.patch

there is also iowait-reason and sleep-stat patch in the same directory.

And maybe try to reproduce the problem with 2.6.5 without mm. People like 
to have reports about "stable" kernels :)


good luck

Grzegorz Kulewski


PS. I am compiling 2.6.5 too to check if it works better for me.

