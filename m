Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbRFRW5c>; Mon, 18 Jun 2001 18:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbRFRW5V>; Mon, 18 Jun 2001 18:57:21 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:14287 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S263400AbRFRW5G>; Mon, 18 Jun 2001 18:57:06 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC2068@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: gnu asm help...
Date: Mon, 18 Jun 2001 15:56:50 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello asm gurus..

I need a simple (??) change to atomic_inc() functionality. so that i can
increment and return the 
value of the variable.

current implementation in linux/include/asm/atomic.h does not do this job.

any help would be greatly appreciated.

ashokr


from atomic.h

also if there is any reference to the gnu asm symtax, please send me a
pointer.. 
i can understand what the LOCK "incl %0 means.. but not sure what the rest
is for.

thanks
ashokr

static __inline__ void atomic_inc(atomic_t *v)
{
    __asm__ __volatile__(
        LOCK "incl %0"
        :"=m" (v->counter)
        :"m" (v->counter));
}



