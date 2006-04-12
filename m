Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWDLDEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWDLDEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 23:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWDLDEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 23:04:37 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:25363 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbWDLDEh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 23:04:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LimJOXIY3pe04ZlYVCu1Er77DGVa/7xcQ0jQpcFtXem3T1mUw6e3A/RPRJ0Gd1Zt41I89BKKkdFLAk40tzqDzI9zH6Tt+DTWUhElVBFf7KxIGnkWyyTabauV1b3XYRh9fp3rXIQd0jDqb3rQE+YEygUV0N3sE+3KFC+EIVfp+6Q=
Message-ID: <bda6d13a0604112004s16ee3c7fo210ef2caeebdcd0e@mail.gmail.com>
Date: Tue, 11 Apr 2006 20:04:36 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: lepton <ytht.net@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 386/smp issue with atomic_add_return()
In-Reply-To: <20060412021340.GA6718@gsy2.lepton.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060412021340.GA6718@gsy2.lepton.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, lepton <ytht.net@gmail.com> wrote:
> Hi
>         Is there any smp box with 386 cpu?
>         If it exist, then I think atomic_add_return has a problem.
>         Just disabling local interrupts can not keep another cpu from entering this function.
>         What do you think about this?
>
>         This is the code (copied from 2.6.16.4):
>
>         #ifdef CONFIG_M386
>  no_xadd: /* Legacy 386 processor */
>         local_irq_disable();
>         __i = atomic_read(v);
>         atomic_set(v, i + __i);
>         local_irq_enable();
>         return i + __i;
>         #endif

If such a box exists (and I doubt), it is not a commody PC.
First x86 SMP motherboard I heard of was a P1 with two processors.
