Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbTEGSVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTEGSVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:21:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:21417 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264150AbTEGSVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:21:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 7 May 2003 11:35:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <20030507174027.GD19324@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.50.0305071107590.2208-100000@blue1.dev.mcafeelabs.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com>
 <20030507164901.GB19324@wohnheim.fh-wedel.de>
 <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com>
 <20030507174027.GD19324@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, [iso-8859-1] Jörn Engel wrote:

> I'm not sure if I got you wrong, or vice versa. Either way, some
> definitions first.
> Process Stack == the traditional per-process kernel stack
> Interrupt Stack == a dedicated per-CPU stack for interrupts only
> CPU Stack == all kernel data on a per-CPU stack
>
> Not for anything would I want a CPU Stack. At first thought, this is
> impossible, but in reality it is just ugly beyond anything I could
> bear.
>
> An Interrupt Stack is a very good thing. I know PPC machines with 125
> Interrupt lines (3 for cascading) that could theoretically all happen
> at once. That alone demands for a stack size well above 8k and having
> this per process is just a bad design. But that is another issue.
>
> The real Process Stack without the interrupt overhead should not need
> to be bigger than 4k. It currently is for all platforms I know about,
> s390 has even 16k. This is the point of my regular allyesconfig
> compilations and postings.
>
> Do you still disagree? Then I must have misread your mail.

It was not really clear you were talking about interrupts stack, that are
a feasible thing. Even though, I'd not feel confident going down to 4k,
looking at the post that started this thread.



- Davide

