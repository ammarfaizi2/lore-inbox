Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUIONjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUIONjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUIONg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:36:56 -0400
Received: from zero.aec.at ([193.170.194.10]:16646 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266115AbUIONaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:30:13 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, kkeil@suse.de
Subject: Re: [patch] tune vmalloc size
References: <2EHyq-5or-39@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 15 Sep 2004 15:29:53 +0200
In-Reply-To: <2EHyq-5or-39@gated-at.bofh.it> (Ingo Molnar's message of "Wed,
 15 Sep 2004 15:00:18 +0200")
Message-ID: <m34qlzbqy6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> there are a few devices that use lots of ioremap space. vmalloc space is
> a showstopper problem for them.
>
> this patch adds the vmalloc=<size> boot parameter to override
> __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> doubles the size.

Ah, Karsten Keil did a similar patch some months ago. There is 
clearly a need.

But I think this should be self tuning instead. For a machine with 
less than 900MB of memory the vmalloc area can be automagically increased,
growing into otherwise unused address space. 

This way many users wouldn't need to specify weird options.  So far
most machines still don't have more than 512MB.

-Andi

