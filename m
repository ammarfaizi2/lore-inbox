Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWAQIRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWAQIRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWAQIRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:17:54 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:1683 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932315AbWAQIRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:17:53 -0500
Date: Tue, 17 Jan 2006 09:17:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave C Boutcher <sleddog@us.ibm.com>, serue@us.ibm.com,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, paulus@au1.ibm.com,
       anton@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060117081749.GA10135@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu> <20060116170907.60149236.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116170907.60149236.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > If I revert just that patch, mm4 boots fine.  Its really not obvious to
> > me at all why that patch is breaking things though...
> 
> Yes, that is strange.  I do recall that if something accidentally 
> enables interrupts too early in boot, ppc64 machines tend to go 
> comatose.  But if we'd been running that code under 
> local_irq_disable(), down() would have spat a warning.

perhaps it was just luck it worked so far, and the bug could have had 
worse incarnations that the current clear hang if a certain generic 
codepath is touched in a perfectly valid way. Does CONFIG_DEBUG_MUTEXES 
(or any of the other debugging options) make any noise?

	Ingo
