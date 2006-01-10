Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWAJKEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWAJKEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWAJKEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:04:20 -0500
Received: from tornado.reub.net ([202.89.145.182]:30377 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751025AbWAJKEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:04:20 -0500
Message-ID: <43C38671.4030805@reub.net>
Date: Tue, 10 Jan 2006 23:03:29 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060109)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
References: <20060109203711.GA25023@kroah.com>	<Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>	<20060109164410.3304a0f6.akpm@osdl.org>	<1136857742.14532.0.camel@localhost.localdomain> <20060109174941.41b617f6.akpm@osdl.org>
In-Reply-To: <20060109174941.41b617f6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2006 2:49 p.m., Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> On Llu, 2006-01-09 at 16:44 -0800, Andrew Morton wrote:
>>> - Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
>>>   or driver core.
>> libata I think. I reproduced it on 2.6.14-mm2 by accident with a buggy
>> pata driver.
> 
> Well that's all merged up now.  Reuben, could you please test 2.6.15git6
> tomorrow?

A couple of reboots later with git6 and at this stage it seems all OK, no oopses.

I'm still having 100% repeatable "soft" hangs when booting up though, both with 
-mm2 (-mm1 seems OK in this regard) and git6.  It's enough to make git6 and mm2 
unusable because the machine never finishes booting userspace.  I'll put more 
details of that in another email following up to the original -mm2 thread, as 
it's unrelated to the oops above (but probably equally as nasty).

But it means I can't test the git6 fixes much more because every time I boot it 
I have to alt-sysrq S+U+B or uncleanly kill the box by hitting the reset button.

reuben
