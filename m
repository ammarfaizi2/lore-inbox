Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131485AbQKQKUW>; Fri, 17 Nov 2000 05:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbQKQKUM>; Fri, 17 Nov 2000 05:20:12 -0500
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:1409 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S131485AbQKQKUD>; Fri, 17 Nov 2000 05:20:03 -0500
Message-ID: <3A14FF48.E554BE1B@home.com>
Date: Fri, 17 Nov 2000 03:50:00 -0600
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Error in x86 CPU capabilities starting with test5/6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been running a plug in for xmms for some time that uses the
aviplay program and avifile library...then when upgrading to test5/6 I
start getting this error message when running xmms:

ERROR: no time-stamp counter found! Quitting.

I finally trace it down to my avi plugin and  then from there to the
actual aviplay program.  I have played with a newer version that had
more specific error messages one of which told me I had a non-intel
compatible x86 with no time-stamp counter and to use ./configure
--disable-tsc to fix  the situation, this is all well and good if the
plugin didn't rely on an older version where even using the config
option will not work, here is my /proc/cpuinfo which shows tsc but
something has got to be wrong with it in recent versions.

contents of /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 733.000092
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1461.45

Jordan Breeding
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
