Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSDQSxD>; Wed, 17 Apr 2002 14:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSDQSxC>; Wed, 17 Apr 2002 14:53:02 -0400
Received: from elin.scali.no ([62.70.89.10]:10258 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313304AbSDQSxB>;
	Wed, 17 Apr 2002 14:53:01 -0400
Date: Wed, 17 Apr 2002 20:52:48 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Ingo Molnar <mingo@elte.hu>
cc: James Bourne <jbourne@MtRoyal.AB.CA>, <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Jeff Nguyen <jeff@aslab.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204171507300.23328-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0204172050410.31755-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Ingo Molnar wrote:

>
> On Wed, 17 Apr 2002, James Bourne wrote:
>
> > After Ingo forwarded me his original patch (I found his patch via a web
> > based medium, which had converted all of the left shifts to compares,
> > and now I'm very glad it didn't boot...) and the system is booted and is
> > balancing most of the interrupts at least.  Here's the current output of
> > /proc/interrupts
> >
> > brynhild:bash$ cat /proc/interrupts
> >            CPU0       CPU1
> >   0:     171414          0    IO-APIC-edge  timer
> >   1:          3          2    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   8:          1          0    IO-APIC-edge  rtc
> >  18:          8          7   IO-APIC-level  aic7xxx
> >  19:      13566      12799   IO-APIC-level  eth0
> >  20:          9          7   IO-APIC-level  aic7xxx
> >  21:          9          7   IO-APIC-level  aic7xxx
> >  27:       1572       5371   IO-APIC-level  megaraid
> > NMI:          0          0
> > LOC:     171315     171251
> > ERR:          0
> > MIS:          0
>
> it's looking good.
>
> > So, the timer isn't being balanced still, others are (is there a
> > specific case in your patch for irq 0 (< 1)?  I couldn't see it but it
> > almost looks as though it's being missed..)
>
> it's a separate bug, solved by a separate patch.
>
> 	Ingo
>

Ingo,

Are any of these patches going into the mainline kernel soon ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

