Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUKABof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUKABof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 20:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUKABod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 20:44:33 -0500
Received: from holomorphy.com ([207.189.100.168]:23170 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261716AbUKABms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 20:42:48 -0500
Date: Sun, 31 Oct 2004 17:42:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
Message-ID: <20041101014230.GC2583@holomorphy.com>
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031233313.GB6909@elf.ucw.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Con Kolivas wrote:
>> This code was designed to touch the least number of files, be completely
>> arch-independant, and allow extra schedulers to be coded in by only
>> touching Kconfig, scheduler.c and scheduler.h. It should incur no
>> overhead when run and will allow you to compile in only the scheduler(s)
>> you desire. This allows, for example, embedded hardware to have a tiny
>> new scheduler that takes up minimal code space.

On Mon, Nov 01, 2004 at 12:33:13AM +0100, Pavel Machek wrote:
> You are changing 
> some_functions()
> into
> something->function()
> no? I do not think that is 0 overhead...

It's nonzero, yes. However, it's rather small with modern branch
predictors; older microarchitectures handled this less well, which
is probably why you expect a measurable hit. It may still have
non-negligible performance effects on some legacy architectures,
but I would not let that hold up progress.


-- wli
