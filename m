Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRJ3NGt>; Tue, 30 Oct 2001 08:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJ3NGk>; Tue, 30 Oct 2001 08:06:40 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:15700 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S273870AbRJ3NGg>; Tue, 30 Oct 2001 08:06:36 -0500
Date: Tue, 30 Oct 2001 12:40:37 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: IO APIC (smp) / crashes ?
Message-ID: <20011030124037.A26140@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using 2.4.13 I still experience crashes when a very specific set of
programs are used.

as I have a Abit BP6 and it's known to be not the best SMP board, I was
wondering if it could be possible that a high rate of interrupts
(specific IRQ's) could cause the 'crashes' I experience.

The setup is really weird. I use freeamp to play streams; I have an
ethernet card connected to a 512kbits adsl router; I use an SB16 under
opensound.com and use X with an AGP card.

if the stuff 'crashes, it in fact doesn't crash but starts to become
_very_ slow. if you look at /proc/interrupts you would see timer ticks
increase one by one but it woud take ages. like one tich in hald an hour
or so. this basically means -- system unuseable. it does respond to
pings though.

my wild guess is that the combination and rate of interrupts cause the
well known 

Oct 30 07:29:37 grobbebol kernel: APIC error on CPU1: 02(08)
Oct 30 07:29:37 grobbebol kernel: APIC error on CPU0: 02(04)
Oct 30 08:30:43 grobbebol kernel: APIC error on CPU0: 04(04)
Oct 30 08:30:43 grobbebol kernel: APIC error on CPU1: 08(08)
[....]

entries that finally after some time hit a combination that causes the
system to become very slow. would that be a possibility or am I just (as
usual :-) wrong ?


           CPU0       CPU1
  0:   13213246   13178957    IO-APIC-edge  timer
  1:      60279      59829    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:      44383      44113    IO-APIC-edge  serial
  4:          3          5    IO-APIC-edge  serial
  5:      75105      73827    IO-APIC-edge  soundblaster
  8:          0          1    IO-APIC-edge  rtc
 14:     218635     212466    IO-APIC-edge  ide0
 15:       6903       6858    IO-APIC-edge  ide1
 18:      30878      30618   IO-APIC-level  BusLogic BT-930
 19:    5695922    5718641   IO-APIC-level  eth0
NMI:          0          0
LOC:   26392880   26392845
ERR:         82
MIS:         70


anyways, it basically only happens when I use X, when I use sound, when
I use xmms _and_ it comes from eth0. it happens not directly but
sometimes, after, say an hour, sometimes after 4 hours.

(fwiw -- it also happens under the opensound drivers in the kernel but
less frequent)

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
