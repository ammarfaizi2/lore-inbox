Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133116AbRD3G3v>; Mon, 30 Apr 2001 02:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136452AbRD3G3m>; Mon, 30 Apr 2001 02:29:42 -0400
Received: from anduin.net ([62.180.76.74]:16356 "HELO anduin.net")
	by vger.kernel.org with SMTP id <S133116AbRD3G3W>;
	Mon, 30 Apr 2001 02:29:22 -0400
From: "Eirik Overby" <ltning@anduin.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 30 Apr 2001 08:29:40 +0100 (CET)
Reply-To: "Eirik Overby" <ltning@anduin.net>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: 2.4.x SMP issues on 440LX (?)
Message-Id: <20010430062932Z133116-409+1416@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

As another person (Aaron M. Folmsbee, 28.04.01-22:32) in here reported earlier, there seems to be problems 
with Intel 440LX chipsets with dual CPU's and the Linux 2.4 kernel series.
Simply stated, this just plain doesn't work right. When sticking in only one CPU, the system boots fine, but I 
see "random" hangs and kernel panics. Watching boot messages and doing a cat /proc/cpuinfo gives the 
correct information; I have one Intel Pentium II installed.
However, when sticking in both CPU's, one of two things happen:
1 - The system doesn't boot at all. It either reboots straight after unpacking the kernel and doing the first CPU 
initializations (can't see when, it's too fast), or it continues with the boot and kernel panics somewhere along 
the way. Example kernel panic output is at the end of this mail. Wether it just reboots or hangs later depends 
on which CPU is installed as CPU1, the two CPU's are both PII's but one is produced in the Phillipines, the 
other in Malaysia.
2 - If I get another CPU produced in the Phillipines, less than 100 serial numbers apart, it boots and lets me log 
in, and _seems_ stable. That is, until I put some load on it. After a few minutes or so it hangs again, or kernel 
panics. Sometimes it gives me a panic message, sometimes not. But it seems to be the same message..

Now the _really_ interesting thing is - and this happens with 2.2 kernels aswell - when having both CPU's 
installed, no matter which ones and where they are produced, it seemingly thinks one of them is a Celeron, 
not a PII. It's always the second CPU, and cat /proc/cpuinfo and the bootmessages are consistent here. The 
first CPU show up correctly as a PII with 256kb cache, the second shows up as a Celeron with 32kb cache.. 
Otherwise the CPU information is 100% equal (which it shouldn't be if it was indeed a celeron, right?). 
Somehow I suspect that the reason for this "misinformation" might also be the reason for the instability.. But 
IANAKH (i am not a kernel hacker), so I wouldn't know.

Hope someone does, though...


Best regards,
Eirik Overby

