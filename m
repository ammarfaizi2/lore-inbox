Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316939AbSEWQOW>; Thu, 23 May 2002 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316940AbSEWQOV>; Thu, 23 May 2002 12:14:21 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:48629 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316939AbSEWQOP>;
	Thu, 23 May 2002 12:14:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.5462.306200.74695@napali.hpl.hp.com>
Date: Thu, 23 May 2002 09:14:14 -0700
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia64 code having CONFIG_X86_LOCAL_APIC
In-Reply-To: <20020523185719.Z2518@in.ibm.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a simple reason for this: the goal is (or at least "was")
that irq.c would eventually become platform-independent.  To prepare
for this, I keep the ia64 version of irq.c as much in sync with the
x86 version as possible (actually, I haven't check recently, so there
may have been some divergence while I wasn't watching).  So, yes,
there is some dead code in the ia64 version, but it does serve the
purpose to minimize the differences with the x86 version.

	--david

>>>>> On Thu, 23 May 2002 18:57:20 +0530, Ravikiran G Thirumalai <kiran@in.ibm.com> said:

  Ravikiran> Hi folks, linux-2.5.17/arch/ia64/kernel/irq.c has a
  Ravikiran> #ifdef CONFIG_X86_LOCAL_APIC, but I dont see the config
  Ravikiran> option in any ia64 config.in files.....  wondering if
  Ravikiran> this is just some piece of code which will never be
  Ravikiran> compiled...

  Ravikiran> Also, linux-2.5.17/arch/ia64/kernel/irq.c prints
  Ravikiran> apic_timer_irqs, and they don't seem to be defined for
  Ravikiran> ia64.  The piece of code (irq.c) is also covered by
  Ravikiran> #ifdef CONFIG_X86 wonder if the condition is ever
  Ravikiran> true.....

  Ravikiran> Pls let me know what I am missing

  Ravikiran> disclaimer: I don't know much about ia64

  Ravikiran> Kiran

  Ravikiran> - To unsubscribe from this list: send the line
  Ravikiran> "unsubscribe linux-kernel" in the body of a message to
  Ravikiran> majordomo@vger.kernel.org More majordomo info at
  Ravikiran> http://vger.kernel.org/majordomo-info.html Please read
  Ravikiran> the FAQ at http://www.tux.org/lkml/

--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/
