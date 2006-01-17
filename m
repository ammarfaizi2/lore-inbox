Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWAQIr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWAQIr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAQIr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:47:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932071AbWAQIr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:47:58 -0500
Date: Tue, 17 Jan 2006 00:47:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: sleddog@us.ibm.com, serue@us.ibm.com, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-Id: <20060117004711.1f4508cd.akpm@osdl.org>
In-Reply-To: <20060117081749.GA10135@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
	<20060115230557.0f07a55c.akpm@osdl.org>
	<200601170000.58134.michael@ellerman.id.au>
	<20060116153748.GA25866@sergelap.austin.ibm.com>
	<20060116215252.GA10538@cs.umn.edu>
	<20060116170907.60149236.akpm@osdl.org>
	<20060117081749.GA10135@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > If I revert just that patch, mm4 boots fine.  Its really not obvious to
> > > me at all why that patch is breaking things though...
> > 
> > Yes, that is strange.  I do recall that if something accidentally 
> > enables interrupts too early in boot, ppc64 machines tend to go 
> > comatose.  But if we'd been running that code under 
> > local_irq_disable(), down() would have spat a warning.
> 
> perhaps it was just luck it worked so far, and the bug could have had 
> worse incarnations that the current clear hang if a certain generic 
> codepath is touched in a perfectly valid way. Does CONFIG_DEBUG_MUTEXES 
> (or any of the other debugging options) make any noise?
> 

The bug happens on the G5 too.  There's nothing useful on the screen,
nothing on netconsole.  Could the people whose machines have a fscking
serial port please try CONFIG_DEBUG_MUTEXES?
