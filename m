Return-Path: <linux-kernel-owner+w=401wt.eu-S1754833AbWL1Moa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbWL1Moa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbWL1Moa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:44:30 -0500
Received: from il.qumranet.com ([62.219.232.206]:53934 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833AbWL1Moa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:44:30 -0500
Message-ID: <4593BC1A.9080503@qumranet.com>
Date: Thu, 28 Dec 2006 14:44:10 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] kvm: fix GFP_KERNEL alloc in atomic section bug
References: <458A57A4.9000807@qumranet.com> <20061228123219.GA27387@elte.hu>
In-Reply-To: <20061228123219.GA27387@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Subject: [patch] kvm: fix GFP_KERNEL alloc in atomic section bug
> From: Ingo Molnar <mingo@elte.hu>
>
> KVM does kmalloc() in an atomic section while having preemption disabled 
> via vcpu_load(). Fix this by moving the ->*_msr setup from the 
> vcpu_setup method to the vcpu_create method.
>
> (This is also a small speedup for setting up a vcpu, which can in theory 
> be more frequent than the vcpu_create method).
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
>   

Applied, thanks.


-- 
error compiling committee.c: too many arguments to function

