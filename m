Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCHW3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUCHW3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:29:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44790 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261347AbUCHW3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:29:15 -0500
Message-ID: <404CF3B4.4020304@mvista.com>
Date: Mon, 08 Mar 2004 14:29:08 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081619.16771.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org> <200403081650.18641.amitkale@emsyssoft.com> <20040308152214.GE15065@smtp.west.cox.net>
In-Reply-To: <20040308152214.GE15065@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Mon, Mar 08, 2004 at 04:50:18PM +0530, Amit S. Kale wrote:
> 
>>On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
>>
>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> 
> [snip]
> 
>>>> If you consider it an absolutely must, we can do something so that the
>>>>dirty part is kept away and info threads almost always works.
>>>
>>>Yes, I'd consider `info threads' support a must-have.  I'm rather surprised
>>>that others do not?
>>
>>Present threads support code changes calling convention of do_IRQ. Most 
>>believe that to be an absolute no.
> 
> 
> I believe that George's version does something totally different, with
> some macros at compile time (and binutils support, I _think_) to not
> have to change do_IRQ.

No, nothing at compile time, at least WRT the threads issue.  There is a 
completely different problem with backtracing through an interrupt or trap.  I 
have sent the patch for that which makes only minimal changes to code (one line 
I think, and that an asm line).  The rest is a dwarft2 set of code to build the 
frame description for the trap/interrupt frame.

> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

