Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbQKGWte>; Tue, 7 Nov 2000 17:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQKGWtO>; Tue, 7 Nov 2000 17:49:14 -0500
Received: from jalon.able.es ([212.97.163.2]:1203 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130209AbQKGWtD>;
	Tue, 7 Nov 2000 17:49:03 -0500
Date: Tue, 7 Nov 2000 23:48:56 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: root@chaos.analogic.com
Cc: "Dr . Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        Chris Meadors <clubneon@hereintown.net>,
        Ulrich Drepper <drepper@redhat.com>, kernel@kvack.org,
        "Dr . David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Message-ID: <20001107234856.C1150@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <Pine.LNX.4.21.0011071401280.4438-100000@sol.compendium-tech.com> <Pine.LNX.3.95.1001107172159.198A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.95.1001107172159.198A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Nov 07, 2000 at 23:31:19 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2000 23:31:19 Richard B. Johnson wrote:
> On Tue, 7 Nov 2000, Dr. Kelsey Hudson wrote:
..
> >  15:        111        130   IO-APIC-level  bttv
> > NMI:  190856196  190856196 
> > LOC:  190858464  190858463 
> > ERR:          0
> > 
..
> 
>            CPU0       CPU1       
>   0:      10945      11869    IO-APIC-edge  timer
>   1:        419        393    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          0          0    IO-APIC-edge  rtc
>  10:       2990       2904   IO-APIC-level  eth0
>  11:       1066       1124   IO-APIC-level  BusLogic BT-958
>  13:          0          0          XT-PIC  fpu
> NMI:      22748      22748 
> LOC:      21731      22229 
> ERR:          0
> 

I have also 2xPII@400, on a SuperMicro mobo. I just get:

werewolf:~/soft/in# uptime
 11:46pm  up  8:38,  0 users,  load average: 0.00, 0.00, 0.00
werewolf:~/soft/in# cat /proc/interrupts
           CPU0       CPU1       
  0:    1553608    1555092    IO-APIC-edge  timer
  1:       1784       1800    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
  9:      12053      11483    IO-APIC-edge  aha152x
 10:      31594      31168   IO-APIC-level  aic7xxx, EMU10K1
 11:   42836648   42865890   IO-APIC-level  eth0, nvidia
 12:     134421     134916    IO-APIC-edge  PS/2 Mouse
 13:          1          0          XT-PIC  fpu
 14:         16          4    IO-APIC-edge  ide0
 15:         10          0    IO-APIC-edge  ide1
NMI:          0
ERR:          0

The only diff I see is:
> model name	: Pentium II (Deschutes)
> stepping	: 1
> cpu MHz		: 400.000915

model name      : Pentium II (Deschutes)
stepping        : 2 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
cpu MHz         : 400.912

Something related to version-detection of processors in kernel init ?

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
