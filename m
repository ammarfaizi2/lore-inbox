Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265017AbUD2WtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265017AbUD2WtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbUD2WtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:49:25 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:45198 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S265017AbUD2WtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:49:17 -0400
In-Reply-To: <20040429223257.GA25166@hockin.org>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com> <20040429223257.GA25166@hockin.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6F370600-9A2F-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: koke@sindominio.net, Paul Wagland <paul@wagland.net>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Rik van Riel <riel@redhat.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       Timothy Miller <miller@techsource.com>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Thu, 29 Apr 2004 18:49:12 -0400
To: Tim Hockin <thockin@hockin.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No Linux spinlocks, kernel structures, interfaces, macros or inlines
whatsoever are used in the binary-only proprietary modem code that
is bundled with our drivers. All Linux-related things are fully 
separated
in open-source modules. As I said before, Linuxant is trying very hard
to attenuate the inconveniences of political constraints for people.

Despite this, like any in complex software, there are occasional
compatibility issues with certain configurations since the kernel
can be wildly customized/patched, APIs are constantly evolving,
and PC hardware incredibly diverse.

But we are here to assume our responsibility in fixing and properly
maintaining the drivers as well as we can.

Marc

On Apr 29, 2004, at 6:32 PM, Tim Hockin wrote:

> On Thu, Apr 29, 2004 at 06:24:58PM -0400, Marc Boucher wrote:
>> The inherent instability of binary modules is a religious myth. Any
>
> No, it's REAL, unless VERY CAREFULLY handled.  If your binary uses a
> spinlock, it either works only on SMP or only on UP.  If your binary 
> uses
> any number of kernel structures and interfaces, you are subject to the
> whims of whomever compiled the kernel.  spinlock debuging changes the
> sizeof(spinlock_t).  Some APIs become macros or inlines depending on
> config options.
>
> You have to toally separate all the kernel code from the binary code. 
> If
> you can't do that, you end up with a kernel module that works ONLY on a
> very small subset of kernels.  And that sucks.  We don't want to 
> encourage
> that.  If your driver manages to cleanly pull out all the binary gunk 
> from
> the kernel gunk, then kudos to you.
>
> I still don't like it, but at least it has a chance of running.
>

