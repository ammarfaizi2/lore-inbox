Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSJYOCe>; Fri, 25 Oct 2002 10:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbSJYOCe>; Fri, 25 Oct 2002 10:02:34 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:33047 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261418AbSJYOCd>;
	Fri, 25 Oct 2002 10:02:33 -0400
Message-ID: <3DB95086.7060505@acm.org>
Date: Fri, 25 Oct 2002 09:09:10 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NMI watchdog not ticking at the right intervals
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I have been working on my NMI patch, I have noticed that the NMI 
watchdog does not seem to be ticking correctly.  I've tried 2.4 and 2.5 
kernels, and I get the same results.  From my reading of the code, it 
should tick once a second.  However, I have had the time between ticks 
vary from around 33 to over 100 seconds.  Tbe time between ticks is 
different on every boot, but is consistent once booted.  Is there some 
divider register that's not getting initialized?

Here's my cpuinfo:

processor    : 0
cpu_package    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 11
model name    : Intel(R) Pentium(R) III Mobile CPU      1066MHz
stepping    : 1
cpu MHz        : 730.601
cache size    : 512 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips    : 1458.17


-Corey

