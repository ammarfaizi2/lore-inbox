Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTJECp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbTJECp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:45:59 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:13899 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S262953AbTJECp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:45:57 -0400
Subject: Re: Problems caused by scheduler tweaks in 2.6.0-test6?
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200310041950.44011.kernel@kolivas.org>
References: <1065188297.2660.17.camel@iso-8590-lx.zeusinc.com>
	 <3F7E8EC0.7080008@cyberone.com.au>  <200310041950.44011.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1065321924.2725.26.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Sat, 04 Oct 2003 22:45:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please send a rundown of what top shows during these occurrences, and please 
> define "hangs". I can't see how the scheduler tweaks can bring the machine 
> down.
> 
> Con

I'm not sure exactly how to get the output from top when running VMware
fullscreen, does it have a way to dump the output to text?  Would
another tool provide you with valuable output?

As far as the Wine/Outlook 2000 issue, I don't know how the scheduler
changes cause this, and for the longest time I never really thought that
was it, I always assumed that it was something else different between
the main and the -mm tree.  However, I'm basically 100% sure that it's
the cause now because I tested with stock -test6 and then applied Nick's
patches for -test6 (which back out your changes) and the problem goes
away.

Hang means that the program simply will never exit, not that the whole
system hangs or anything.  When you exit Outlook it synchronizes the
mailbox before it exits and the closes down the connection.  The program
hangs with a "Please wait while Outlook exits" message a this never goes
away.  It's 100% repeatable with your scheduler tweaks, and never
happens with Nick's patches.  What can I provide for that issue?  Top
output shows the process sleeping, not using any CPU.  I can kill the
process and it will exit.

I guess my concern is that I seem to run into a lot of issues that I
consider bad behavior.  I've outlined the issues with Acrobat to you
before and you stated that you had profiled it.  Well this is something
I use almost every day and with these scheduler tweaks it becomes almost
unusable.  With Nicks patches, or even stock -test5 it works great.

Basically for me these tweaks significantly degrade three major programs
that I use to do work related activities (VMware, Acrobat, and to some
extent Crossover Office).  I'll be glad to help where I can, tell me
what information would help you.

Later,
Tom


