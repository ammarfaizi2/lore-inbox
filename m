Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbRBZOeR>; Mon, 26 Feb 2001 09:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130274AbRBZOck>; Mon, 26 Feb 2001 09:32:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130263AbRBZO3p>;
	Mon, 26 Feb 2001 09:29:45 -0500
Date: Mon, 26 Feb 2001 11:13:28 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: apic patches (with MIS counter)
Message-ID: <20010226111328.A24978@grobbebol.xs4all.nl>
In-Reply-To: <Pine.LNX.4.21.0102211758290.2050-100000@penguin.homenet> <Pine.GSO.3.96.1010222111316.2302A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.3.96.1010222111316.2302A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Feb 22, 2001 at 11:16:06AM +0100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej,

with the patch you sent (with MIS counter code) :

           CPU0       CPU1
  0:   50644222   50826974    IO-APIC-edge  timer
  1:     239631     233690    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:     344151     345715    IO-APIC-edge  serial
  4:          4          4    IO-APIC-edge  serial
  5:     331569     327717    IO-APIC-edge  soundblaster
  8:     268433     271449    IO-APIC-edge  rtc
 14:     919801     913328    IO-APIC-edge  ide0
 15:      22625      21407    IO-APIC-edge  ide1
 18:     149973     150537   IO-APIC-level  BusLogic BT-930
 19:    5557525    5554806   IO-APIC-level  eth0
NMI:  101420638  101425054
LOC:  101475956  101475952
ERR:         90
MIS:      34865

and  11:09am  up 11 days, 17:52,  8 users,  load average: 1.44, 1.15,
     0.77 uptime.

it seems like it is time to get at least the suggestions so far in the
mainstream kernel or at least in Alan's tree. (it's not clear if it has
been already included)

There are a few things that might be related though -- some slow network
performance but I am not sure if that is caused by the patch. I don't
think so but..; I also didn't hammer the whole day on sound to crash it.
typically, a flood ping, sound & backup --> crash within minutes and I
wanted to see how it performs (e.g. no crash) under normal loads. that
part succeeded.

if you like, I can start banging the machine on it's head now.


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
