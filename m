Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUIOPHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUIOPHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUIOPHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:07:20 -0400
Received: from jade.spiritone.com ([216.99.193.136]:56029 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266376AbUIOPHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:07:18 -0400
Date: Wed, 15 Sep 2004 08:07:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, kkeil@suse.de
Subject: Re: [patch] tune vmalloc size
Message-ID: <783300000.1095260820@[10.10.2.4]>
In-Reply-To: <m34qlzbqy6.fsf@averell.firstfloor.org>
References: <2EHyq-5or-39@gated-at.bofh.it> <m34qlzbqy6.fsf@averell.firstfloor.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andi Kleen <ak@muc.de> wrote (on Wednesday, September 15, 2004 15:29:53 +0200):

> Ingo Molnar <mingo@elte.hu> writes:
> 
>> there are a few devices that use lots of ioremap space. vmalloc space is
>> a showstopper problem for them.
>> 
>> this patch adds the vmalloc=<size> boot parameter to override
>> __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
>> doubles the size.
> 
> Ah, Karsten Keil did a similar patch some months ago. There is 
> clearly a need.
> 
> But I think this should be self tuning instead. For a machine with 
> less than 900MB of memory the vmalloc area can be automagically increased,
> growing into otherwise unused address space. 
> 
> This way many users wouldn't need to specify weird options.  So far
> most machines still don't have more than 512MB.

It already does that, IIRC.

M.

