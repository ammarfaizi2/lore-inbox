Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293520AbSB1Ri7>; Thu, 28 Feb 2002 12:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSB1Rg6>; Thu, 28 Feb 2002 12:36:58 -0500
Received: from gsm2.lmt.lv ([212.93.96.2]:29713 "HELO gsm2.lmt.lv")
	by vger.kernel.org with SMTP id <S293641AbSB1RgH>;
	Thu, 28 Feb 2002 12:36:07 -0500
Message-ID: <3C7E6A84.DED890F6@lmt.lv>
Date: Thu, 28 Feb 2002 19:36:04 +0200
From: Andrejs Dubovskis <adu@lmt.lv>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: serial console in single mode does not function
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When system with serial console is started in single mode it boots
shell. But any button pressed in terminal does not go to console.
Looks like hanged system. Nothing changed but kernel (2.4.14) only
and serial console works as expected: any pressed chars are displayed
in console.
Kernels 2.4.17 and 2.4.18 was checked and do not function.
Systems are Alpha Avanti and Alpha Miata (some info provided below).

[andrejs@host linux]$ cat /proc/version
Linux version 2.4.17 (andrejs@host) (gcc version 2.96 20000731
(Red Hat Linux 7.0)) #1 Wed Jan 2 09:37:16 EET 2002

[andrejs@host linux]$ cat /proc/cpuinfo 
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Miata
system variation        : 0
system revision         : 0
system serial number    : 
cycle frequency [Hz]    : 499747351 est.
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 992.88
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 12 (pc=1200027e8,va=20000284712)
platform string         : Digital Personal WorkStation 500au
cpus detected           : 1

[andrejs@host linux]$ cat /etc/aboot.conf 
1:1/boot/vmlinuz-2.4.17 root=/dev/sda1 ro console=ttyS0 single

[andrejs@host linux]$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-0080 : rtc
  0070-007f : rtc
00a0-00bf : pic2
00c0-00df : dma2
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
03f8-03ff : serial(auto)
8000-807f : Digital Equipment Corporation DECchip 21142/43
  8000-807f : tulip
8080-808f : Contaq Microsystems 82c693 (#2)
  8080-8087 : ide0
  8088-808f : ide1
9000-90fe : qlogicisp
