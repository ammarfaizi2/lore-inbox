Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289043AbSAFVRd>; Sun, 6 Jan 2002 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSAFVQa>; Sun, 6 Jan 2002 16:16:30 -0500
Received: from 24-ZARA-X8.libre.retevision.es ([62.82.228.152]:27909 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S289044AbSAFVQA>;
	Sun, 6 Jan 2002 16:16:00 -0500
Message-ID: <3C388442.102@zaralinux.com>
Date: Sun, 06 Jan 2002 18:07:14 +0100
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-smp <linux-smp@vger.kernel.org>
Subject: xmms child blocked at end (2.4.18pre1)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I have a very strange thing here.

I have a 2x200mmx using 2.4.18pre1, xmms 1.2.5, xawtv-3.61 and XFree86 
Version 4.1.0.

The situation is that I have a nfs mounted share with mp3, using xmms to 
play them, (3c503 over coax) everithing goes well until I put xawtv in 
fullscreen mode. I don't know why, but at this time in short time the 
child thread of xmms blocks for a long time in end, having xawtv in a 
window does not cause this.

Here is a vmstat 1 log:

    procs                      memory    swap          io     system 
      cpu
  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us 
  sy  id
  4  0  0  58864   2928   3172  41072   0   0     0     0  153  1213  30 
  13  57
  1  1  0  58864   2932   3156  41088   0   0     0     0  150  1166  20 
  14  66
  2  1  0  58864   2932   3156  41088   0   0     0     0  152  1115  20 
  20  60
  0  1  0  58864   2920   3164  41088   0   0     0    12  161  1117  20 
  20  60
  1  1  0  58864   2920   3164  41088   0   0     0     0  160  1119  19 
  20  62
  2  1  0  58864   2920   3164  41088   0   0     0     0  153  1212   9 
  28  63
  0  1  0  58864   3288   3164  41088   0   0     0     0  161  1086  16 
  17  68
  0  1  0  58864   3272   3164  41100   0   0     0     0  155  1030  12 
  16  72
  0  1  0  58864   3264   3172  41088   0   0     0    56  174   978  14 
  14  72
  0  1  0  58864   3272   3172  41088   0   0     0     0  156   992   8 
  15  77
  1  1  0  58864   3264   3172  41088   0   0     0     0  159  1012   9 
  15  76
  1  1  0  58864   3264   3172  41088   0   0     0     0  151  1044  10 
   9  81
  2  1  0  58864   3256   3172  41088   0   0     0     0  276  1265  17 
  18  66
  3  1  0  58864   3256   3180  41088   0   0     0    12  398  1832  30 
  23  47
  0  1  0  58864   3244   3180  41088   0   0     0     0  278  1412  19 
  15  66
  0  1  0  58864   3252   3180  41088   0   0     0     0  151  1068  10 
   5  85
  0  1  0  58864   3244   3180  41088   0   0     0     0  155  1150  10 
  10  80
  2  0  0  58864   3232   3188  41088   0   0     0    12  193   951  20 
  24  56
  2  0  0  58864   3156   3188  41088   0   0     0     0  155   834  72 
  13  16

The only blocked task is xmms child, as I said it's blocked in end, so 
it empties it's buffer and you can hear it

Another thing I have noticed is that when I have a big transfer with 
this card (I have another 3c595) and having xawtv in full screen I can 
see dropped frames, I assume this is for the speed downgrade of the pci 
bus to acomodate isa tranfers, the 3c503 is a very old isa nic, and my 
tv capture is a pci bt848.

Don't know if this rings a bell of somebody.

P.D. Sorry for my bad english.

-- 
Jorge Nerin
<comandante@zaralinux.com>

