Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbQJ1NEl>; Sat, 28 Oct 2000 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQJ1NEc>; Sat, 28 Oct 2000 09:04:32 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:30473 "HELO
	gateway.izba.bg") by vger.kernel.org with SMTP id <S130464AbQJ1NER>;
	Sat, 28 Oct 2000 09:04:17 -0400
Date: Sat, 28 Oct 2000 19:04:12 +0300 (EEST)
From: <lnxkrnl@mail.ludost.net>
To: linux-kernel@vger.kernel.org
Subject: PLIP driver in 2.2.xx kernels
Message-ID: <Pine.LNX.4.10.10010281859580.3112-100000@doom.izba.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have a question - Why does the PLIP driver does consume so much CPU ?
I tried it today, and when i did ping -s 16000 dst_ip, the kernel consumed
about 50% of the CPU time ( /proc/cpuinfo and /proc/interrupts follow).
Any ideas ?

shtajga:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 548.545
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 psn mmx fxsr xmm
bogomips        : 1094.45
shtajga:~# cat /proc/interrupts
           CPU0
  0:   32765032          XT-PIC  timer
  1:     227971          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:   42658190          XT-PIC  serial
  4:  518726307          XT-PIC  serial
  7:      45966          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:      15292          XT-PIC  eth0
 10:   21984776          XT-PIC  eth1
 11:    1534661          XT-PIC  sm200
 12:     498413          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:   18221483          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
