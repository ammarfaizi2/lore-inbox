Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267170AbSLRF5d>; Wed, 18 Dec 2002 00:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLRF5d>; Wed, 18 Dec 2002 00:57:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48901 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267170AbSLRF5c>; Wed, 18 Dec 2002 00:57:32 -0500
Date: Tue, 17 Dec 2002 22:06:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andi Kleen <ak@suse.de>, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3E0006D2.3000907@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0212172205590.1233-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Dec 2002, Brian Gerst wrote:
>
> How about this patch?  Instead of making a per-cpu trampoline, write to
> the msr during each context switch.

I wanted to avoid slowing down the context switch, but I didn't actually
time how much the MSR write hurts you (it needs to be conditional, though,
I think).

		Linus

