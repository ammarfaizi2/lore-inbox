Return-Path: <linux-kernel-owner+w=401wt.eu-S1030372AbWLaR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWLaR6N (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWLaR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:58:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:35031 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030372AbWLaR6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:58:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FO2hGbC/Fj2dDCtKkT/9xI/shBw87MvXp6erNzqZfXonhof6kLJ/b38kXKjHO8YyetAzOliar+rkvV3RcaW62AkL11gO81KvXtffy2KZpdEcgszqj36yfe0pwAMpxLr9tFXGm7MjV+1OL79k4DXvZ1NrdOHBTYWwkNFySWfJvL4=
Message-ID: <68676e00612310958s6fc602dam5fb01eb62821c725@mail.gmail.com>
Date: Sun, 31 Dec 2006 18:58:11 +0100
From: Luca <kronos.it@gmail.com>
To: "Avi Kivity" <avi@qumranet.com>
Subject: Re: [KVM][PATCH] smp_processor_id() and sleeping functions used in invalid context
Cc: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
In-Reply-To: <4597F851.8060800@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061231170147.GA8695@dreamland.darkstar.lan>
	 <4597F851.8060800@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/06, Avi Kivity <avi@qumranet.com> wrote:
> Luca Tettamanti wrote:
> > Hello,
> > I'm testing KVM on a Core2 CPU. I'm running kernel 2.6.20-git (pulled
> > few hours ago), configured with SMP and PREEMPT.
> >
> > I'm hitting 2 different warnings:
> > BUG: using smp_processor_id() in preemptible [00000001] code: kvm/7726
> > caller is vmx_create_vcpu+0x9/0x2f [kvm_intel]
>
> [...]
> > Second one:
> > BUG: sleeping function called from invalid context at
> > /home/kronos/src/linux-2.6.git/mm/slab.c:3034
> > in_atomic():1, irqs_disabled():0
> > 1 lock held by kvm/12706:
> >  #0:  (&vcpu->mutex){--..}, at: [<f1b68d02>] kvm_dev_ioctl+0x113/0xf97
> > [kvm]
> >  [<b015c32a>] kmem_cache_alloc+0x1b/0x6f
> >
> [...]
>
> There are patches for both (I think) flying around.  They should land in
> Linus' tree in a few days.

Ah, I just saw them on lkml...

Luca
