Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268332AbUHLCEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268332AbUHLCEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUHLCEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:04:51 -0400
Received: from holomorphy.com ([207.189.100.168]:7560 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268332AbUHLCEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:04:39 -0400
Date: Wed, 11 Aug 2004 19:04:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040812020424.GB11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com> <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, William Lee Irwin III wrote:
>> I actually favored making C language spin_lock() (i.e. the goddamn
>> thing is declared as a C function void spin_lock(spinlock_t *) and is
>> called like a normal C function -- no inline asm or inline C functions
>> at all) entrypoints beyond merely conslidating contention loops, but I
>> feared that would be too extreme of a reversal of the status quo to
>> ever get traction to post it. It did, however, shrink the kernel text
>> the most of any of the out-of-line spinlock patches by a large margin,
>> something completely absurd-sounding, like 220KB vs. 20KB-60KB. =)

On Wed, Aug 11, 2004 at 09:37:36PM -0400, Zwane Mwaikambo wrote:
> Could you post the patch and the results? It'd also be interesting to see
> the function call setup in a number of cases.

Odd, it was either you or mpm who told me the results. I personally
never even tried running the thing. I was merely told some other, prior
attempt at doing some kind of spinlock uninlining failed to run, this
thing did, and that it shaved that memorable amount off of .text size.
I recall I compiled it myself and saw about half as much reduction
(120KB instead of 220KB), possibly due to .config or compiler differences.
I'll dust things off and so on.

-- wli
