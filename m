Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314097AbSDVHkV>; Mon, 22 Apr 2002 03:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314098AbSDVHkU>; Mon, 22 Apr 2002 03:40:20 -0400
Received: from jalon.able.es ([212.97.163.2]:4272 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314097AbSDVHkU>;
	Mon, 22 Apr 2002 03:40:20 -0400
Date: Mon, 22 Apr 2002 09:40:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam4
Message-ID: <20020422074013.GA7294@werewolf.able.es>
In-Reply-To: <1019457056.591.18.camel@voyager>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.22 Norbert Kiesel wrote:
>Hi,
>
>I had two compile problems:
>1) sched.c complains about missing local_bh_count, TQUEUE_BH, ...
>2) init/do_mounts.c complains about SCHED_YIELD (if initrd is enabled)
>
>The following patch fixes both problems for me.
>
[...]

Yup, there are files not covered by 20-sched-O1-rml-1.
Fast search:

werewolf:/usr/src/linux# grep -r SCHED_YIELD *
arch/alpha/mm/fault.c:          current->policy |= SCHED_YIELD;
arch/mips/mm/fault.c:           tsk->policy |= SCHED_YIELD;
arch/ppc/mm/fault.c:            current->policy |= SCHED_YIELD;
arch/m68k/mm/fault.c:           current->policy |= SCHED_YIELD;
arch/arm/mm/fault-common.c:     tsk->policy |= SCHED_YIELD;
arch/sh/mm/fault.c:             current->policy |= SCHED_YIELD;
arch/ia64/mm/fault.c:           current->policy |= SCHED_YIELD;
arch/mips64/mm/fault.c:         tsk->policy |= SCHED_YIELD;
arch/s390/mm/fault.c:           tsk->policy |= SCHED_YIELD;
arch/s390x/mm/fault.c:          tsk->policy |= SCHED_YIELD;
init/do_mounts.c:                       current->policy |= SCHED_YIELD;

I will try to make similar changes for those in a -jam5.

Many thanks.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam4 #1 SMP lun abr 22 00:52:56 CEST 2002 i686
