Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVLLLv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVLLLv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVLLLv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:51:27 -0500
Received: from mail.suse.de ([195.135.220.2]:64976 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751239AbVLLLv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:51:27 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net>
	<20051116182145.GP31287@waste.org>
	<f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com>
	<20051212103611.GA6416@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 12 Dec 2005 09:22:42 -0700
In-Reply-To: <20051212103611.GA6416@elte.hu>
Message-ID: <p73u0denv3h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> 
> in the past couple of years i saw double-faults at a rate of perhaps 
> once a year - and i frequently hack lowlevel glue code! So the 
> usefulness of this code in the field, and especially on an embedded 
> platforms, is extremely limited.

If it only saves an hour or developer time on some bug report
it has already justified its value.

Also to really save memory there are much better areas
of attack than this relatively slim code.

> in fact, i've experienced triple-faults (== spontaneous reboots) to be 
> at least 10 times more frequent than double-faults! I.e. _if_ your 
> kernel (or hardware) is screwed up to the degree that it would 
> double-fault, it will much more likely also triple-fault.

A common case where this doesn't hold is breaking the [er]sp 
in kernel code.

-Andi (who sees double faults more often) 
