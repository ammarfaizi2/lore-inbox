Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbSLDGoW>; Wed, 4 Dec 2002 01:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbSLDGoW>; Wed, 4 Dec 2002 01:44:22 -0500
Received: from dilbert.sider.net ([200.196.245.9]:60089 "EHLO
	dilbert.sider.net") by vger.kernel.org with ESMTP
	id <S266933AbSLDGoV>; Wed, 4 Dec 2002 01:44:21 -0500
Date: Wed, 4 Dec 2002 04:52:58 -0200
From: Felipe Massia <felmasper@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: timer glitch (solved?)
Message-Id: <20021204045258.590d7732.felmasper@yahoo.com.br>
X-Mailer: Sylpheed version 0.8.6claws9 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My clock, some times, gives wrong results. When I call the folowing
command

  bash$ while : ; do date ; done

the time shown is not correct. When the seconds are changing, for a
small period of time, the time is offset by about 1h12min. E.g. when the
clock is changing from 1h30min30sec to 1h30min31sec, some 2 or 3 lines
shown are 2h42min.

I don't know how to reproduce the problem. It seems the timer enters
this wrong state after using mplayer (maybe because it's
"timer-hungry").

I've read the "timer glitch on 2.4.18: solved" thread in this list and I
think it's the same problem.

Still not clear to me: should I experience this problem w/ 2.4.19? Is there a way so I can have the clock working properly?

BTW, I don't know if it's important to mention: I'm using rtc. But even
when I remove the rtc module, the problem persists.


Some data on my system (maybe useful):

$ uname -a
Linux felipe 2.4.19-k6 #1 Sun Oct 6 19:53:19 EST 2002 i586 AMD-K6(tm) 3D processor AuthenticAMD GNU/Linux

# kernel-image for k6 from Debian unstable

$ dmesg | grep -i via
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:07.1
parport_pc: Via 686A parallel port: io=0x378

# I read something about VIA686 mb in the thread

$ cat /proc/cpuinfo

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 501.157


tia,
Felipe
