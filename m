Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWBPTFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWBPTFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBPTFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:05:17 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:50418 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932319AbWBPTFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:05:15 -0500
Date: Thu, 16 Feb 2006 11:04:17 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
In-Reply-To: <20060216172007.GB29151@elte.hu>
Message-ID: <Pine.LNX.4.64.0602161055100.30911@dhcp153.mvista.com>
References: <20060215151711.GA31569@elte.hu> <20060216145823.GA25759@linuxtv.org>
 <20060216172007.GB29151@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006, Ingo Molnar wrote:

>
> * Johannes Stezenbach <js@linuxtv.org> wrote:
>
>> Anyway: If a process can trash its robust futext list and then die
>> with a segfault, why are the futexes still robust? In this case the
>> kernel has no way to wake up waiters with FUTEX_OWNER_DEAD, or does
>> it?
>
> that's memory corruption - which robust futexes do not (and cannot)
> solve. Robustness is mostly about handling sudden death (e.g. which is
> due to oom, or is due to a user killing the task, or due to the
> application crashing in some non-memory-corrupting way), but it cannot
> handle all possible failure modes.

 	I don't think this is a weakness in Dave or Inaky's versions. Dave 
at least maintained the bulk of the information in kernel space. The 
uaddr was used for the fast locking in userspace, but not for maintaining 
the robustness .

Correct me if I'm wrong Dave.

Daniel
