Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315855AbSEGPEM>; Tue, 7 May 2002 11:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315853AbSEGPEK>; Tue, 7 May 2002 11:04:10 -0400
Received: from jalon.able.es ([212.97.163.2]:61855 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315854AbSEGPEG>;
	Tue, 7 May 2002 11:04:06 -0400
Date: Tue, 7 May 2002 17:03:57 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: irqbalance+O(1)-sched
Message-ID: <20020507150357.GA2142@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I am trying to mix the irqbalance patch on top of the O1-scheduler
to use it on a dual P4 box.

Everything mix easy but this piece of code in irqbalance:

int idle_cpu(int cpu)
{
   return cpu_curr(cpu) == idle_task(cpu);
}

2.4.18 defines it as 

sched.c:#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
...
sched.c:#define idle_task(cpu) (&init_task)

but O1 kills it.

Any syggestion on hwo to implement idle_cpu() on top of O1 ?

Thanks

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam1 #1 SMP mar may 7 01:51:45 CEST 2002 i686
