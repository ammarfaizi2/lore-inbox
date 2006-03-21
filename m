Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWCUID0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWCUID0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWCUID0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:03:26 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:60365 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751355AbWCUIDZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:03:25 -0500
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16 - cpufreq doesn't find Celeron (Pentium4/XEON) processor
Date: Tue, 21 Mar 2006 09:02:18 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603210902.19335.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

up to 2.6.15 my kernel worked to find my processor and frequency scalling was 
possible via cpufreq. I have 

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2398.803
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4801.41

Now it is screwed up...

My config:
  │ │ [*] CPU Frequency scaling                                                                                                        
│ │
  │ │ [ ]   Enable CPUfreq debugging                                                                                                   
│ │
  │ │ <*>   CPU frequency translation statistics                                                                                       
│ │
  │ │ [*]     CPU frequency translation statistics details                                                                             
│ │
  │ │       Default CPUFreq governor (userspace)  --->                                                                                 
│ │
  │ │ <*>   'performance' governor                                                                                                     
│ │
  │ │ <*>   'powersave' governor                                                                                                       
│ │
  │ │ ---   'userspace' governor for userspace frequency scaling                                                                       
│ │
  │ │ <*>   'ondemand' cpufreq policy governor                                                                                         
│ │
  │ │ <*>   'conservative' cpufreq governor                                                                                            
│ │
  │ │ ---   CPUFreq processor drivers                                                                                                  
│ │
  │ │ < >   ACPI Processor P-States driver                                                                                             
│ │
  │ │ < >   AMD Mobile K6-2/K6-3 PowerNow!                                                                                             
│ │
  │ │ < >   AMD Mobile Athlon/Duron PowerNow!                                                                                          
│ │
  │ │ < >   AMD Opteron/Athlon64 PowerNow!                                                                                             
│ │
  │ │ < >   Cyrix MediaGX/NatSemi Geode Suspend Modulation                                                                             
│ │
  │ │ < >   Intel Enhanced SpeedStep                                                                                                   
│ │
  │ │ < >   Intel Speedstep on ICH-M chipsets (ioport interface)                                                                       
│ │
  │ │ < >   Intel SpeedStep on 440BX/ZX/MX chipsets (SMI interface)                                                                    
│ │
  │ │ <*>   Intel Pentium 4 clock modulation                                                                                           
│ │
  │ │ < >   nVidia nForce2 FSB changing                                                                                                
│ │
  │ │ < >   Transmeta LongRun                                                                                                          
│ │
  │ │ < >   VIA Cyrix III Longhaul                                                                                                     
│ │
  │ │ ---   shared options                                                                                                             
│ │


Thanks for fixing

Michal
