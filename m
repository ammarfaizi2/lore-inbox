Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313044AbSDJRQv>; Wed, 10 Apr 2002 13:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313352AbSDJRQu>; Wed, 10 Apr 2002 13:16:50 -0400
Received: from dsl-65-185-37-21.telocity.com ([65.185.37.21]:17325 "EHLO
	onevista.com") by vger.kernel.org with ESMTP id <S313044AbSDJRQp>;
	Wed, 10 Apr 2002 13:16:45 -0400
Reply-To: johna@onevista.com
Message-Id: <200204101716.NAA30717@onevista.com>
Content-Type: text/plain; charset=US-ASCII
From: John Adams <johna@onevista.com>
Organization: One Vista Associates
To: linux-kernel-owner@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>,
        Brent Cook <busterb@mail.utexas.edu>
Subject: Re: Mouse interrupts: the death knell of a VP6
Date: Wed, 10 Apr 2002 12:16:39 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020206191108.A11277@suse.de> <20020410083504.Y60587-100000@ozma.union.utexas.edu> <20020410192339.A22777@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 11:23 am, Oleg Drokin wrote:
> Hello!
>
> On Wed, Apr 10, 2002 at 09:02:05AM -0500, Brent Cook wrote:
> > I have an ABIT VP6 motherboard, using the VIA Apollo chipset and 2
> > 700Mhz PIII's, but please don't hold that against me. The system is
> > running 2.4.19-pre6. I believe that I either have a system that has
> > trouble handling a sudden bursts of interrupts, or have found a fault
> > in mouse handling.
>
> Have you tried to change MPS mode to 1.1 from 1.4 (I see addres message
> timeouts in your log)?
>
> > I have already tried removing memory, adding memory, changing
> > processors, video cards. The only thing that has remained constant is
> > the VP6 motherboard and the hard drive.
>
> My VP6 died on me recently with some funny symptoms:
> it hangs in X when I start netscape and move mouse, or if I do
> bk clone on kernel tree, it dies with
> kernel BUG at /usr/src/linux-2.4.18/include/asm/smplock.h:62!
> BUG in various places pretty soon.
> (this BUG is only appears if 2 CPUs are present in motherboard).
> So if your troubles began only recently, you might want to try another
> motherboard just to be sure.

I have a VP6 with 2 CPUs.  Its has both a PS/2 mouse and a usb mouse.  Its 
been up for 90 days and handled lots of mouse interrupts.  See below.
           CPU0       CPU1       
  0:  392228152  392338774    IO-APIC-edge  timer
  1:     312494     312380    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          1          3    IO-APIC-edge  serial
 12:   40362907   40324010    IO-APIC-edge  PS/2 Mouse
 14:    3386577    3383180    IO-APIC-edge  ide0
 15:     679030     672810    IO-APIC-edge  ide1
 17:    1165246    1162993   IO-APIC-level  DC395x_TRM
 18:   83937970   83935445   IO-APIC-level  ide2, eth0
 19:     131956     132468   IO-APIC-level  es1371, usb-uhci, usb-uhci
NMI:          0          0 
LOC:  784686934  784686951 
ERR:        191
MIS:          0

Its running a recent kernel.  Maybe 2.4.18 is broken.  Here's a uname -a
Linux flash 2.5.0 #16 SMP Wed Jan 9 16:48:16 EST 2002 i686 unknown

johna
