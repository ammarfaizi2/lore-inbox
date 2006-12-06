Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937564AbWLFTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937564AbWLFTsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937568AbWLFTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:48:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937564AbWLFTr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:47:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061206191252.GH32748@xi.wantstofly.org> 
References: <20061206191252.GH32748@xi.wantstofly.org>  <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> 
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 19:47:22 +0000
Message-ID: <28668.1165434442@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek <buytenh@wantstofly.org> wrote:

> > Pre-v6 ARM doesn't support SMP according to ARM's atomic.h,
> 
> That's not quite true, there exist ARMv5 processors that in theory
> can support SMP.

I meant that the Linux ARM arch doesn't support it:

	#else /* ARM_ARCH_6 */

	#include <asm/system.h>

	#ifdef CONFIG_SMP
	#error SMP not supported on pre-ARMv6 CPUs
	#endif

David
