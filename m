Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSJYXoZ>; Fri, 25 Oct 2002 19:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSJYXoZ>; Fri, 25 Oct 2002 19:44:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51925 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261690AbSJYXoV>;
	Fri, 25 Oct 2002 19:44:21 -0400
Date: Fri, 25 Oct 2002 16:45:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Message-ID: <517430000.1035589532@flay>
In-Reply-To: <515310000.1035588399@flay>
References: <200210242351.56719.efocht@ess.nec.de> <2862423467.1035473915@[10.10.2.3]> <200210251015.46388.efocht@ess.nec.de> <515310000.1035588399@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> divide error: 0000
>  
> CPU:    4
> EIP:    0060:[<c011ac38>]    Not tainted
> EFLAGS: 00010002
> EIP is at task_to_steal+0x118/0x260
> eax: 00000001   ebx: f01c5040   ecx: 00000000   edx: 00000000
> esi: 00000063   edi: f01c5020   ebp: f0197ee8   esp: f0197eac
> ds: 0068   es: 0068   ss: 0068
> Process swapper (pid: 0, threadinfo=f0196000 task=f01bf060)
> Stack: 00000000 f01b4120 00000000 c02ec940 f0197ed4 00000004 00000000 c02ecd3c 
>        c02ec93c 00000000 00000001 0000007d c02ec4a0 00000001 00000004 f0197f1c 
>        c011829c c02ec4a0 00000004 00000004 00000001 00000000 c39376c0 00000000 
> Call Trace:
>  [<c011829c>] load_balance+0x8c/0x140
>  [<c0118588>] scheduler_tick+0x238/0x360
>  [<c0123347>] tasklet_hi_action+0x77/0xc0
>  [<c0105420>] default_idle+0x0/0x50
>  [<c0126bd5>] update_process_times+0x45/0x60
>  [<c0113faa>] smp_apic_timer_interrupt+0x11a/0x120
>  [<c0105420>] default_idle+0x0/0x50
>  [<c010815e>] apic_timer_interrupt+0x1a/0x20
>  [<c0105420>] default_idle+0x0/0x50
>  [<c0105420>] default_idle+0x0/0x50
>  [<c010544a>] default_idle+0x2a/0x50
>  [<c01054ea>] cpu_idle+0x3a/0x50
>  [<c011db20>] printk+0x140/0x180
> 
> Code: f7 75 cc 8b 55 c8 83 f8 64 0f 4c f0 39 4d ec 8d 46 64 0f 44 


Dump of assembler code for function task_to_steal:
0xc011ab20 <task_to_steal>:     push   %ebp
0xc011ab21 <task_to_steal+1>:   mov    %esp,%ebp
0xc011ab23 <task_to_steal+3>:   push   %edi
0xc011ab24 <task_to_steal+4>:   push   %esi
0xc011ab25 <task_to_steal+5>:   push   %ebx
0xc011ab26 <task_to_steal+6>:   sub    $0x30,%esp
0xc011ab29 <task_to_steal+9>:   movl   $0x0,0xffffffdc(%ebp)
0xc011ab30 <task_to_steal+16>:  mov    0xc(%ebp),%eax
0xc011ab33 <task_to_steal+19>:  movl   $0x0,0xffffffe8(%ebp)
0xc011ab3a <task_to_steal+26>:  mov    0x8(%ebp),%edx
0xc011ab3d <task_to_steal+29>:  mov    0xc034afe0(,%eax,4),%eax
0xc011ab44 <task_to_steal+36>:  sar    $0x4,%eax
0xc011ab47 <task_to_steal+39>:  mov    %eax,0xffffffec(%ebp)
0xc011ab4a <task_to_steal+42>:  mov    0x20(%edx),%eax
0xc011ab4d <task_to_steal+45>:  mov    (%eax),%esi
0xc011ab4f <task_to_steal+47>:  test   %esi,%esi
0xc011ab51 <task_to_steal+49>:  je     0xc011ad6a <task_to_steal+586>
0xc011ab57 <task_to_steal+55>:  mov    %eax,0xffffffe4(%ebp)
0xc011ab5a <task_to_steal+58>:  movl   $0x0,0xfffffff0(%ebp)
0xc011ab61 <task_to_steal+65>:  mov    0xffffffe4(%ebp),%ebx
0xc011ab64 <task_to_steal+68>:  add    $0x4,%ebx
0xc011ab67 <task_to_steal+71>:  mov    %ebx,0xffffffd0(%ebp)
0xc011ab6a <task_to_steal+74>:  lea    0x0(%esi),%esi
0xc011ab70 <task_to_steal+80>:  mov    0xfffffff0(%ebp),%ebx
0xc011ab73 <task_to_steal+83>:  test   %ebx,%ebx
0xc011ab75 <task_to_steal+85>:  jne    0xc011acec <task_to_steal+460>
0xc011ab7b <task_to_steal+91>:  mov    0xffffffe4(%ebp),%edx
0xc011ab7e <task_to_steal+94>:  mov    0x4(%edx),%eax
0xc011ab81 <task_to_steal+97>:  test   %eax,%eax
0xc011ab83 <task_to_steal+99>:  jne    0xc011ace4 <task_to_steal+452>
0xc011ab89 <task_to_steal+105>: mov    0xffffffd0(%ebp),%ecx
0xc011ab8c <task_to_steal+108>: mov    0x4(%ecx),%eax
0xc011ab8f <task_to_steal+111>: test   %eax,%eax
0xc011ab91 <task_to_steal+113>: jne    0xc011acd9 <task_to_steal+441>
0xc011ab97 <task_to_steal+119>: mov    0xffffffd0(%ebp),%ebx
0xc011ab9a <task_to_steal+122>: mov    0x8(%ebx),%eax
0xc011ab9d <task_to_steal+125>: test   %eax,%eax
0xc011ab9f <task_to_steal+127>: jne    0xc011acce <task_to_steal+430>
0xc011aba5 <task_to_steal+133>: mov    0xffffffd0(%ebp),%edx
0xc011aba8 <task_to_steal+136>: mov    0xc(%edx),%eax
0xc011abab <task_to_steal+139>: test   %eax,%eax
0xc011abad <task_to_steal+141>: je     0xc011acbf <task_to_steal+415>
0xc011abb3 <task_to_steal+147>: bsf    %eax,%eax
0xc011abb6 <task_to_steal+150>: add    $0x60,%eax
0xc011abb9 <task_to_steal+153>: mov    %eax,0xfffffff0(%ebp)
0xc011abbc <task_to_steal+156>: cmpl   $0x8c,0xfffffff0(%ebp)
0xc011abc3 <task_to_steal+163>: je     0xc011ac9e <task_to_steal+382>
0xc011abc9 <task_to_steal+169>: mov    0xfffffff0(%ebp),%ebx
0xc011abcc <task_to_steal+172>: mov    0xffffffe4(%ebp),%eax
0xc011abcf <task_to_steal+175>: mov    0xc034b4e0,%edx
0xc011abd5 <task_to_steal+181>: lea    0x18(%eax,%ebx,8),%ebx
0xc011abd9 <task_to_steal+185>: mov    %ebx,0xffffffe0(%ebp)
0xc011abdc <task_to_steal+188>: mov    0x4(%ebx),%ebx
0xc011abdf <task_to_steal+191>: mov    %edx,0xffffffcc(%ebp)
0xc011abe2 <task_to_steal+194>: lea    0x0(%esi,1),%esi
0xc011abe9 <task_to_steal+201>: lea    0x0(%edi,1),%edi
0xc011abf0 <task_to_steal+208>: lea    0xffffffe0(%ebx),%edi
0xc011abf3 <task_to_steal+211>: mov    0xc0348e68,%eax
0xc011abf8 <task_to_steal+216>: mov    0x30(%edi),%edx
0xc011abfb <task_to_steal+219>: sub    %edx,%eax
0xc011abfd <task_to_steal+221>: cmp    0xffffffcc(%ebp),%eax
0xc011ac00 <task_to_steal+224>: jbe    0xc011ac70 <task_to_steal+336>
0xc011ac02 <task_to_steal+226>: mov    0x8(%ebp),%ecx
0xc011ac05 <task_to_steal+229>: mov    0x14(%ecx),%ecx
0xc011ac08 <task_to_steal+232>: cmp    %ecx,%edi
0xc011ac0a <task_to_steal+234>: mov    %ecx,0xffffffc8(%ebp)
0xc011ac0d <task_to_steal+237>: je     0xc011ac70 <task_to_steal+336>
0xc011ac0f <task_to_steal+239>: movzbl 0xc(%ebp),%ecx
0xc011ac13 <task_to_steal+243>: mov    0x38(%edi),%eax
0xc011ac16 <task_to_steal+246>: shr    %cl,%eax
0xc011ac18 <task_to_steal+248>: and    $0x1,%eax
0xc011ac1b <task_to_steal+251>: je     0xc011ac70 <task_to_steal+336>
0xc011ac1d <task_to_steal+253>: mov    0x48(%edi),%esi
0xc011ac20 <task_to_steal+256>: test   %esi,%esi
0xc011ac22 <task_to_steal+258>: jne    0xc011ac83 <task_to_steal+355>
0xc011ac24 <task_to_steal+260>: mov    0xc0348e68,%eax
0xc011ac29 <task_to_steal+265>: xor    %edx,%edx
0xc011ac2b <task_to_steal+267>: mov    $0x63,%esi
0xc011ac30 <task_to_steal+272>: mov    0x30(%edi),%ecx
0xc011ac33 <task_to_steal+275>: sub    %ecx,%eax
0xc011ac35 <task_to_steal+277>: mov    0x44(%edi),%ecx
0xc011ac38 <task_to_steal+280>: divl   0xffffffcc(%ebp)
0xc011ac3b <task_to_steal+283>: mov    0xffffffc8(%ebp),%edx
0xc011ac3e <task_to_steal+286>: cmp    $0x64,%eax
0xc011ac41 <task_to_steal+289>: cmovl  %eax,%esi
0xc011ac44 <task_to_steal+292>: cmp    %ecx,0xffffffec(%ebp)
0xc011ac47 <task_to_steal+295>: lea    0x64(%esi),%eax
0xc011ac4a <task_to_steal+298>: cmove  %eax,%esi
0xc011ac4d <task_to_steal+301>: mov    0x4(%edx),%eax
0xc011ac50 <task_to_steal+304>: lea    0xffffff9c(%esi),%edx
0xc011ac53 <task_to_steal+307>: mov    0xc(%eax),%eax
0xc011ac56 <task_to_steal+310>: mov    0xc034afe0(,%eax,4),%eax
0xc011ac5d <task_to_steal+317>: sar    $0x4,%eax
0xc011ac60 <task_to_steal+320>: cmp    %eax,%ecx
0xc011ac62 <task_to_steal+322>: cmove  %edx,%esi
0xc011ac65 <task_to_steal+325>: cmp    0xffffffdc(%ebp),%esi
0xc011ac68 <task_to_steal+328>: jle    0xc011ac70 <task_to_steal+336>
0xc011ac6a <task_to_steal+330>: mov    %esi,0xffffffdc(%ebp)
0xc011ac6d <task_to_steal+333>: mov    %edi,0xffffffe8(%ebp)
0xc011ac70 <task_to_steal+336>: mov    (%ebx),%ebx
0xc011ac72 <task_to_steal+338>: cmp    0xffffffe0(%ebp),%ebx
0xc011ac75 <task_to_steal+341>: jne    0xc011abf0 <task_to_steal+208>
0xc011ac7b <task_to_steal+347>: incl   0xfffffff0(%ebp)
0xc011ac7e <task_to_steal+350>: jmp    0xc011ab70 <task_to_steal+80>
0xc011ac83 <task_to_steal+355>: mov    %edi,(%esp,1)
0xc011ac86 <task_to_steal+358>: call   0xc0118070 <upd_node_mem>
0xc011ac8b <task_to_steal+363>: mov    0x8(%ebp),%edx
0xc011ac8e <task_to_steal+366>: mov    0xc034b4e0,%eax
0xc011ac93 <task_to_steal+371>: mov    %eax,0xffffffcc(%ebp)
0xc011ac96 <task_to_steal+374>: mov    0x14(%edx),%edx
0xc011ac99 <task_to_steal+377>: mov    %edx,0xffffffc8(%ebp)
0xc011ac9c <task_to_steal+380>: jmp    0xc011ac24 <task_to_steal+260>
0xc011ac9e <task_to_steal+382>: mov    0x8(%ebp),%eax
0xc011aca1 <task_to_steal+385>: mov    0xffffffe4(%ebp),%edx
0xc011aca4 <task_to_steal+388>: cmp    0x20(%eax),%edx
0xc011aca7 <task_to_steal+391>: jne    0xc011acb4 <task_to_steal+404>
0xc011aca9 <task_to_steal+393>: mov    0x1c(%eax),%ecx
0xc011acac <task_to_steal+396>: mov    %ecx,0xffffffe4(%ebp)
0xc011acaf <task_to_steal+399>: jmp    0xc011ab5a <task_to_steal+58>
0xc011acb4 <task_to_steal+404>: mov    0xffffffe8(%ebp),%eax
0xc011acb7 <task_to_steal+407>: add    $0x30,%esp
0xc011acba <task_to_steal+410>: pop    %ebx
0xc011acbb <task_to_steal+411>: pop    %esi
0xc011acbc <task_to_steal+412>: pop    %edi
0xc011acbd <task_to_steal+413>: pop    %ebp
0xc011acbe <task_to_steal+414>: ret    
0xc011acbf <task_to_steal+415>: mov    0xffffffd0(%ebp),%ecx
0xc011acc2 <task_to_steal+418>: bsf    0x10(%ecx),%eax
0xc011acc6 <task_to_steal+422>: sub    $0xffffff80,%eax
0xc011acc9 <task_to_steal+425>: jmp    0xc011abb9 <task_to_steal+153>
0xc011acce <task_to_steal+430>: bsf    %eax,%eax
0xc011acd1 <task_to_steal+433>: add    $0x40,%eax
0xc011acd4 <task_to_steal+436>: jmp    0xc011abb9 <task_to_steal+153>
0xc011acd9 <task_to_steal+441>: bsf    %eax,%eax
0xc011acdc <task_to_steal+444>: add    $0x20,%eax
0xc011acdf <task_to_steal+447>: jmp    0xc011abb9 <task_to_steal+153>
0xc011ace4 <task_to_steal+452>: bsf    %eax,%eax
0xc011ace7 <task_to_steal+455>: jmp    0xc011abb9 <task_to_steal+153>
0xc011acec <task_to_steal+460>: mov    0xfffffff0(%ebp),%eax
0xc011acef <task_to_steal+463>: xor    %esi,%esi
0xc011acf1 <task_to_steal+465>: mov    0xfffffff0(%ebp),%ecx
0xc011acf4 <task_to_steal+468>: mov    0xffffffd0(%ebp),%ebx
0xc011acf7 <task_to_steal+471>: sar    $0x5,%eax
0xc011acfa <task_to_steal+474>: and    $0x1f,%ecx
0xc011acfd <task_to_steal+477>: lea    (%ebx,%eax,4),%edi
0xc011ad00 <task_to_steal+480>: je     0xc011ad2b <task_to_steal+523>
0xc011ad02 <task_to_steal+482>: mov    (%edi),%eax
0xc011ad04 <task_to_steal+484>: shr    %cl,%eax
0xc011ad06 <task_to_steal+486>: bsf    %eax,%esi
0xc011ad09 <task_to_steal+489>: jne    0xc011ad10 <task_to_steal+496>
0xc011ad0b <task_to_steal+491>: mov    $0x20,%esi
0xc011ad10 <task_to_steal+496>: mov    $0x20,%eax
0xc011ad15 <task_to_steal+501>: sub    %ecx,%eax
0xc011ad17 <task_to_steal+503>: cmp    %eax,%esi
0xc011ad19 <task_to_steal+505>: jge    0xc011ad26 <task_to_steal+518>
0xc011ad1b <task_to_steal+507>: mov    0xfffffff0(%ebp),%edx
0xc011ad1e <task_to_steal+510>: lea    (%edx,%esi,1),%eax
0xc011ad21 <task_to_steal+513>: jmp    0xc011abb9 <task_to_steal+153>
0xc011ad26 <task_to_steal+518>: mov    %eax,%esi
0xc011ad28 <task_to_steal+520>: add    $0x4,%edi
0xc011ad2b <task_to_steal+523>: mov    0xffffffd0(%ebp),%ecx
0xc011ad2e <task_to_steal+526>: mov    %edi,%eax
0xc011ad30 <task_to_steal+528>: mov    $0x8c,%edx
0xc011ad35 <task_to_steal+533>: mov    %edi,%ebx
0xc011ad37 <task_to_steal+535>: sub    %ecx,%eax
0xc011ad39 <task_to_steal+537>: shl    $0x3,%eax
0xc011ad3c <task_to_steal+540>: sub    %eax,%edx
0xc011ad3e <task_to_steal+542>: add    $0x1f,%edx
0xc011ad41 <task_to_steal+545>: shr    $0x5,%edx
0xc011ad44 <task_to_steal+548>: mov    %edx,0xffffffd4(%ebp)
0xc011ad47 <task_to_steal+551>: mov    %edx,%ecx
0xc011ad49 <task_to_steal+553>: xor    %eax,%eax
0xc011ad4b <task_to_steal+555>: repz scas %es:(%edi),%eax
0xc011ad4d <task_to_steal+557>: je     0xc011ad55 <task_to_steal+565>
0xc011ad4f <task_to_steal+559>: lea    0xfffffffc(%edi),%edi
0xc011ad52 <task_to_steal+562>: bsf    (%edi),%eax
0xc011ad55 <task_to_steal+565>: sub    %ebx,%edi
0xc011ad57 <task_to_steal+567>: shl    $0x3,%edi
0xc011ad5a <task_to_steal+570>: add    %edi,%eax
0xc011ad5c <task_to_steal+572>: mov    %eax,%edx
0xc011ad5e <task_to_steal+574>: mov    0xfffffff0(%ebp),%eax
0xc011ad61 <task_to_steal+577>: add    %esi,%eax
0xc011ad63 <task_to_steal+579>: add    %edx,%eax
0xc011ad65 <task_to_steal+581>: jmp    0xc011abb9 <task_to_steal+153>
0xc011ad6a <task_to_steal+586>: mov    0x8(%ebp),%ecx
0xc011ad6d <task_to_steal+589>: mov    0x1c(%ecx),%ecx
0xc011ad70 <task_to_steal+592>: jmp    0xc011acac <task_to_steal+396>
0xc011ad75 <task_to_steal+597>: nop    
0xc011ad76 <task_to_steal+598>: lea    0x0(%esi),%esi
0xc011ad79 <task_to_steal+601>: lea    0x0(%edi,1),%edi
End of assembler dump.

