Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRJJJGU>; Wed, 10 Oct 2001 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275115AbRJJJGB>; Wed, 10 Oct 2001 05:06:01 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:36491 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S275110AbRJJJF5>;
	Wed, 10 Oct 2001 05:05:57 -0400
Date: Wed, 10 Oct 2001 11:06:26 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Dave Jones <davej@suse.de>
Cc: Jose_Jorge@teklynx.fr, linux-kernel@vger.kernel.org
Subject: Re: kapmidled and AMD K6-2
Message-ID: <20011010110626.M30428@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <OFD647EAB7.926A3491-ONC1256AE0.00534E9E@bradycorp.com> <Pine.LNX.4.30.0110091735160.31520-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.30.0110091735160.31520-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.19i
X-Uptime: 12:53:32 up 5 days, 16:11,  9 users,  load average: 0.08, 0.02, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've heard reports from Athlon users who also say HLT doesn't
> do anything regarding temperature for their systems. I wonder
> if it also has a similar feature tucked away in an MSR somewhere..

I think I can confirm this:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1009.015
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2011.95

tranquil:~# uptime
 09:57:59 up  4:42,  2 users,  load average: 0.00, 0.00, 0.00
tranquil:~# vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 601324  55064  57588   0   0     5     4  102    52   0   0 100
 0  0  0      0 601324  55064  57588   0   0     0     0  106    66   0   0 100
 0  0  0      0 601324  55064  57588   0   0     0     0  104    57   0   0 100
 0  0  0      0 601324  55064  57588   0   0     0     0  106    63   0   0 100
 0  0  0      0 601324  55064  57588   0   0     0     0  104    57   0   0 100
 0  0  0      0 601324  55064  57588   0   0     0     0  104    65   0   0 100

tranquil:~# sensors | tail | egrep 'CPU|Mobo'
CPU fan:  6308 RPM  (min = 3000 RPM, div = 2)                     
Mobo Temp: +30.0°C  (limit =  +60°C, hysteresis =  +50°C)        
CPU  Temp:   +49°C  (limit =  +67°C, hysteresis =  +60°C)        (beep)


With kernel compile it goes to 52 degrees, which makes 3 degrees 
difference between almost 100% idle and almost 0.0% idle. 
This is with kernel 2.4.10-ac10 if it matters.

	Ookhoi
