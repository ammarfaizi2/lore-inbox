Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272392AbTHEDJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272393AbTHEDJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:09:09 -0400
Received: from dyn-ctb-210-9-244-254.webone.com.au ([210.9.244.254]:43275 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272392AbTHEDJB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:09:01 -0400
Message-ID: <3F2F1F80.7060207@cyberone.com.au>
Date: Tue, 05 Aug 2003 13:07:44 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
References: <200307301038.49869.kernel@kolivas.org> <20030802225513.GE32488@holomorphy.com> <200308030119.47474.m.c.p@wolk-project.de> <200308042106.51676.m.c.p@wolk-project.de> <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au> <20030805024103.GM32488@holomorphy.com>
In-Reply-To: <20030805024103.GM32488@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Tue, Aug 05, 2003 at 10:56:16AM +1000, Nick Piggin wrote:
>
>>I'm an IO scheduler type person! What help do you need? I haven't been
>>following the thread.
>>
>
>I'm not sure it was in the thread. Basically, the testers appear to
>associate skips with changes in writeout and/or readin behavior (either
>large amounts of writeout or low amounts of readin), though the effect
>of behavior similar to that surrounding a skip doesn't appear to
>guarantee a skip.
>

Right.

snip vmstat

>
>The load IIRC was some kind of io to an IDE disk while xmms played.
>
>About all I can tell is that when there is a skip, bi is low, but
>the converse does not hold. This appears to be independent of io
>scheduler (I had them try deadline too), and I'm very unsure what to
>make of it. I originally suspected thundering herds from waitqueue
>hashing but things appear to contradict that given the low cs rates.
>

So yeah it could easily be that for example the cpu scheduler is
causing the skip and the low IO rates.

>
>I'm collecting instrumentation patches to see what's going on. The
>first order of business is probably getting the testers to run with
>sleepometer to see if and where they're blocking, but given the io bits
>that are observable some elevator instrumentation might help too (and
>whatever it takes to figure out if a driver is spinning wildly too!).
>

Let me know if you come up with anything significant ;)

