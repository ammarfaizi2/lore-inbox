Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281971AbRKUUeK>; Wed, 21 Nov 2001 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281972AbRKUUd7>; Wed, 21 Nov 2001 15:33:59 -0500
Received: from colorfullife.com ([216.156.138.34]:2823 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281971AbRKUUdz>;
	Wed, 21 Nov 2001 15:33:55 -0500
Message-ID: <3BFC0FB5.74DA304D@colorfullife.com>
Date: Wed, 21 Nov 2001 21:33:57 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: trond.myklebust@fys.uio.no, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5
In-Reply-To: <200111211923.WAA18924@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> >                               should consider disabled local interrupts as
> > 'in_irq()'
> 
> How to do this?
>
Arch specific, like __global_cli() in arch/i386/kernel/irq.c.
What about a rate-limited warning if dev_kfree_skb_any is called with
disabled interrupts?

--
	Manfred
