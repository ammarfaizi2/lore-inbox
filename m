Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUCBB0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 20:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUCBB0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 20:26:20 -0500
Received: from alt.aurema.com ([203.217.18.57]:18367 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261531AbUCBB0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 20:26:18 -0500
Message-ID: <4043E2A0.9000107@aurema.com>
Date: Tue, 02 Mar 2004 12:25:52 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Paul Jackson <pj@sgi.com>, Joachim B Haga <c.j.b.haga@fys.uio.no>,
       miller@techsource.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <16450.32046.538912.553878@wombat.chubb.wattle.id.au>
In-Reply-To: <16450.32046.538912.553878@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
>>>>>>"Paul" == Paul Jackson <pj@sgi.com> writes:
> 
> 
> 
> Paul> Is there anyway to provide a mechanism that would support
> Paul> administering a system as follows:
> 
> Paul>   1) Users get so much CPU usage allowed, determined by an upper
> Paul> limit on a running average of the combined CPU usage of all
> Paul> their tasks, with a half life perhaps on the order of minutes.
> 
> Paul>   2) They can nice their tasks up and down, within a decent
> Paul> range, as they will.
> 
> Paul>   3) But if they push too close to their allowed limit, all
> Paul> their tasks get reined in.  The relative priorities within their
> Paul> own tasks are not changed, but the priority of their tasks
> Paul> relative to other users is weakened.
> 
> This is exactly what the commercial product ARMtech does.  The EBS
> that Aurema have just released as open source is (a small) part of the
> commercial product.

Not strictly speaking a part of our commercial product but based on the 
CPU scheduling technology in that product.  As you know, the CPU 
scheduler in the kernel based versions of our product relies on a 
generic "plug in scheduler" interface being present in the host kernel 
and runtime loadable kernel modules plug into that interface and take 
over scheduling.  This mechanism (while allowing our product to work on 
a number of different host operating systems) has the disadvantage that 
it adds some overhead to the scheduler (this is in addition to the extra 
overhead involved in hierarchical scheduling) and places some 
restrictions on the scheduler design as it cannot make too many 
assumptions about the underlying scheduler in the host operating system.

When the technology is used to build an embedded scheduler (as is the 
case with EBS) significant improvements in efficiency can be realised. 
So EBS is a souped up, non hierarchical version of our CPU scheduler 
designed specially for Linux.

> 
> See http://www.aurema.com
> 
> Peter C (an ex-employee of Aurema)
> 
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*

Cheers
Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


