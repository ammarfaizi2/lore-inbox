Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280062AbRJaEkH>; Tue, 30 Oct 2001 23:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280065AbRJaEj5>; Tue, 30 Oct 2001 23:39:57 -0500
Received: from mail.crol.net ([213.191.143.189]:22921 "EHLO crolvax.crol.net")
	by vger.kernel.org with ESMTP id <S280062AbRJaEjo>;
	Tue, 30 Oct 2001 23:39:44 -0500
To: linux-kernel@vger.kernel.org
Subject: free/cache/buffer horror in 2.4.13
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: CRoL d.o.o.
X-Operating-System: GNU/Linux 2.4.12
From: Miroslav Zubcic <mvz@crol.net>
Date: 31 Oct 2001 05:40:13 +0100
Message-ID: <lzhesgxw0i.fsf@crolvax.crol.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for posting this if this is something "normal". But i
noticed strange behaviour in 2.4.13

Machine:
intel PIII 500Mhz, 256Mb RAM kernel 2.4.13

I'm using linux almost 5 years from now, and I never seen such weird
thing. Machine is up 2-3 days after compiling kernel, and all was OK
but now I see ... this:


(root){crolvax}[mail]# free
             total       used       free     shared    buffers     cached
Mem:        255768     146392     109376          0      75376 4294953228
-/+ buffers/cache: -4294882212 4295137980
                   ^^^^^^^^^^^^^^^^^^^^^^
Swap:       530104     100612     429492

(root){crolvax}[mail]# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  261906432 150003712 111902720        0 77258752  1638400
Swap: 542826496 103010304 439816192
MemTotal:       255768 kB
MemFree:        109280 kB
MemShared:           0 kB
Buffers:         75448 kB
Cached:       4294953236 kB
           ^^^^^^^^^^^^^^^
SwapCached:      15660 kB
Active:           5932 kB
Inactive:        71116 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255768 kB
LowFree:        109280 kB
SwapTotal:      530104 kB
SwapFree:       429508 kB

(root){crolvax}[mail]# xosview 
Warning:  meter MemMeter had a negative value of -4207443968.000000 for field 0
Warning:  meter MemMeter had a negative value of -4207448064.000000 for field 0
Warning:  meter MemMeter had a negative value of -4207448064.000000 for field 0

Is this behaviour normal? Log files and syslog are not reporting
anything about that.


-- 
This signature intentionally left blank

