Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTLJLCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 06:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTLJLCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 06:02:12 -0500
Received: from [217.174.98.164] ([217.174.98.164]:46991 "EHLO ari.home")
	by vger.kernel.org with ESMTP id S263486AbTLJLCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 06:02:08 -0500
Date: Wed, 10 Dec 2003 14:02:18 +0300 (MSK)
From: "Lev A. Melnikovsky" <leva@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: +2.4.23 Re: Hang after adding swap in 2.4.19-2.4.22
In-Reply-To: <Pine.LNX.4.58.0312031440160.10231@gu5.xncvgmn.enf.eh>
Message-ID: <Pine.LNX.4.58.0312101311260.10959@nev.ubzr>
References: <Pine.LNX.4.58.0312031440160.10231@gu5.xncvgmn.enf.eh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  On Wed, 3 Dec 2003 at 3:37pm, Lev A. Melnikovsky wrote:

> I have this problem quite long already, I first noticed it when switched
> from 2.4.18 to 2.4.19 and it is still here with 2.4.22 (have not tried
> 2.4.23 yet). The system "hangs" during the early stages of initscripts
> execution. In my case these are RedHat initscripts (several versions
> tried) but other people reported similar problems with Mandrake (look for
> the words like "hang finding module dependencies" or "hang mounting local
> filesystems"). There was a similar post to the LKML (Brad Tilley, Jun 23
> 2003, "OS Fails to Load"). Unfortunately the problem is not 100%
> reproduceable in the sense the system "hangs" some 10%-50% (your mileage
> may vary) of times. On the other side the problem was seen here at three
> separate computers with quite different hardware (well, all CPUs are i386,
> but they are Celeron 533, Athlon XP 2200+ and XP 1700+).
have to reply to my own message since got no answer to the original post.
The problem is already reproduced with 2.4.23. I have managed to catch the
"hang" in two slightly different situations, both kernel message logs
(along with ksymoops and addr2line outputs) are available at
http://kapitza.ras.ru/~leva/ops.2.4.23.tar.bz2

The things common to all the computers involved in my experiments are
reiserfs root filesystem and devfs (see .config)

The kernel used is plain vanilla 2.4.23 with a patch from
http://w.ods.org/tools/kmsgdump/0.4.4/patch-2.4.23p6-kmsgdump-0.4.4.gz

As I have written earlier, the problem occurs with different computers and
I doubt that the hardware details may be important. Still, here's info for
my desktop where the logs were obtained (actually this stuff can be found
in the top of the log):

[leva@desk leva]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1700+
stepping        : 1
cpu MHz         : 1470.012
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2936.01

Not overclocked, no vmware (mostly no modules at all - the hang usually
happens quite early in the boot), no nothing. And, by the way, Seagate
harddrives in all boxes, if this matters.

As before, if replying, please CC me, as I am not subscribed.
I will appreciate any help
-L.
