Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271138AbRHOLJ6>; Wed, 15 Aug 2001 07:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271139AbRHOLJs>; Wed, 15 Aug 2001 07:09:48 -0400
Received: from biancha.hardboiledegg.com ([66.38.186.202]:25362 "HELO
	biancha.hardboiledegg.com") by vger.kernel.org with SMTP
	id <S271138AbRHOLJg>; Wed, 15 Aug 2001 07:09:36 -0400
Date: Wed, 15 Aug 2001 07:09:34 -0400
From: Marc Heckmann <heckmann@hbesoftware.com>
To: linux-kernel@vger.kernel.org
Subject: oops in procfs: 2.4.8-pre7
Message-ID: <20010815070934.B27813@hbe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this happened under high vm load while using vmstat:


Oops: kernel access of bad area, sig: 11                                        
NIP: C005DEDC XER: 00000000 LR: C005B78C SP: C1251E10 REGS: c1251d60 TRAP: 
0300 Using defaults from ksymoops -t elf32-powerpc -a powerpc:common          
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11                                 
TASK = c1250000[1386] 'vmstat' Last syscall: 3                                  
last math c4568000 last altivec 00000000                                        
GPR00: 00002000 C1251E10 C1250000 C8CC8000 C7262000 C01536F0 C5549880 
00000000  GPR08: 00007262 7FFFE000 00000000 00000000 84004883 10019BEC 
7FFFF678 7FFFF680  GPR16: 00000000 00000000 C7262000 00000052 00000625 
00000440 00000000 C8CC8232  GPR24: C0003CE0 7FFFF634 0020D000 C1251EA8 
C1251EA0 C681A67C C681A660 C8CC8000  Call backtrace:                    
C58631A0 C005B78C C003A980 C0003D3C 1000141C 10000E18 0FEB5308                  
00000000                                                                        
Warning (Oops_read): Code line not seen, dumping what data is available  
>NIP; c005dedc <proc_pid_stat+104/300>   <=====                                
Trace; c58631a0 <_end+567567c/d64853c>                                          
Trace; c005b78c <proc_info_read+74/19c>                                         
Trace; c003a980 <sys_read+c8/114>                                               
Trace; c0003d3c <ret_from_syscall_1+0/b4>                                       
Trace; 1000141c Before first symbol                                             
Trace; 10000e18 Before first symbol                                             
Trace; 0feb5308 Before first symbol                                             
Trace; 00000000 Before first symbol                

	-marc                          

