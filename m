Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbTC0OSu>; Thu, 27 Mar 2003 09:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbTC0OSu>; Thu, 27 Mar 2003 09:18:50 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:48400 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S262607AbTC0OSs>; Thu, 27 Mar 2003 09:18:48 -0500
From: Chris Evans <chris@scary.beasts.org>
To: lkml <linux-kernel@vger.kernel.org>
Reply-To: Chris Evans <chris@scary.beasts.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 217.163.5.253
Subject: CPU2 gone "missing" on 4 CPU box.
Message-Id: <E18yYOI-0006Ps-00@sphinx.mythic-beasts.com>
Date: Thu, 27 Mar 2003 14:30:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

I've got a very interesting problem with a 4 CPU box. I've
never seen anything quite like it.
After booting, all 4 CPUs seem to be available (e.g.
/proc/cpuinfo sees them all), but one of them is never
used for anything. It always stays at 100% idle. So it
is effectively a 3 CPU box :-(

There is a highly suspicious entry in the kernel logs
after bootup. It shows some differing values for the CPU
which does not come up properly. Here is the entry:

cpu: 0, clocks: 996796, slice: 199359
CPU0<T0:996784,T1:797424,D:1,S:199359,C:996796>
cpu: 1, clocks: 996796, slice: 199359
cpu: 2, clocks: 996796, slice: 199359
cpu: 3, clocks: 996796, slice: 199359
CPU2<T0:996784,T1:-133220960,D:133619667,S:199359,C:996796>
CPU1<T0:996784,T1:598064,D:2,S:199359,C:996796>
CPU3<T0:996784,T1:199344,D:4,S:199359,C:996796>

As you can see, CPU2 has some weird looking values for
"T1" and "D", compared with CPU0, CPU1 and CPU3.

Has anyone seen anything like this?

The kernel is:
Linux <snip> 2.4.9-e.12enterprise #1 SMP Tue Feb 11
01:29:18 EST 2003 i686 unknown

I'm not entirely sure what the hardware is because the
machine is remote.

Thanks in advance.
Chris

