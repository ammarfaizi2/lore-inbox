Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280768AbRKLNjg>; Mon, 12 Nov 2001 08:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRKLNj0>; Mon, 12 Nov 2001 08:39:26 -0500
Received: from [195.63.194.11] ([195.63.194.11]:8453 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S280768AbRKLNjO>;
	Mon, 12 Nov 2001 08:39:14 -0500
Message-ID: <3BEFDD5C.A778F6D1@evision-ventures.com>
Date: Mon, 12 Nov 2001 15:31:56 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Ricky Beam <jfbeam@bluetopia.net>, linux-kernel@vger.kernel.org
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <200111121331.fACDVf1E007161@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Ricky Beam <jfbeam@bluetopia.net> said:
> > >the discussion is irrelevant. Despite what everybody thinks, Linus thinks
> > >/proc must be not binary, so it will stay that way for those of us who run
> > >Linus kernels...
> >
> > Linus has been "wrong" before.  It will require good code and numbers
> > backing that codes "goodness" before Linus will begin to listen.  Yes,
> > a new procfs format will break a great deal of userland toys, so the
> > changes had better be worth it and sufficient to never, EVER require
> > a complete overhaul in the future.
> 
> /proc for process info is a given (many Unices have it, it is nice at least
> for compatibility).
> 
> /proc for random other garbage should go away. To get at some value you can
> get via specialized calls by read(2) also is just kernel bloat.

My absolute favourite is the following in arch/i386/kernel/irq.c!!!!

Disease symptoms like this are distributed all over the kernel code.

========================================================================
static struct proc_dir_entry * root_irq_dir;
static struct proc_dir_entry * irq_dir [NR_IRQS];

#define HEX_DIGITS 8

static unsigned int parse_hex_value (const char *buffer,
		unsigned long count, unsigned long *ret)
{
	unsigned char hexnum [HEX_DIGITS];
	unsigned long value;
	int i;
