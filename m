Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbSJBVkv>; Wed, 2 Oct 2002 17:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbSJBVkv>; Wed, 2 Oct 2002 17:40:51 -0400
Received: from aneto.able.es ([212.97.163.22]:35471 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S262619AbSJBVkg>;
	Wed, 2 Oct 2002 17:40:36 -0400
Date: Wed, 2 Oct 2002 23:45:40 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre8aa2
Message-ID: <20021002214540.GA2589@werewolf.able.es>
References: <20021002071110.GC1158@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021002071110.GC1158@dualathlon.random>; from andrea@suse.de on Wed, Oct 02, 2002 at 09:11:10 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.02 Andrea Arcangeli wrote:
>URL:
>
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2.gz
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2/
>
>Changelog between 2.4.20pre8aa1 and 2.4.20pre8aa2:
>

I was rediffing the task_cpu patch, when reached a new hunk in -aa:

kernel/sched.c::sched_init(void):

+   current->cpu = smp_processor_id();

As include/asm-i386/smp.h says, 

#define smp_processor_id() (current->cpu)

So you have a harmless and useless assignment...
unless you really wanted to do any other thing, or
smp_processor_id() != current->cpu in some arch.

???

TIA

--
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre8-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
