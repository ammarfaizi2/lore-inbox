Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVAEVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVAEVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAEVvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:51:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:62124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262615AbVAEVuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:50:13 -0500
Date: Wed, 5 Jan 2005 13:49:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: andreas.schnaiter@leo-computer.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 3996] New: system hangs on boot - VIA, SMP,
 PIII 1GHz
Message-Id: <20050105134957.0d5eef84.akpm@osdl.org>
In-Reply-To: <200501051942.j05JgkcQ013658@fire-1.osdl.org>
References: <200501051942.j05JgkcQ013658@fire-1.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bugme-daemon@osdl.org wrote:
>
> http://bugme.osdl.org/show_bug.cgi?id=3996
> 
>            Summary: system hangs on boot - VIA, SMP, PIII 1GHz

Seems to be related to APIC interrupt startup, yes?  Did any earlier 2.6
kernel work correctly?

>     Kernel Version: 2.6.10
>             Status: NEW
>           Severity: high
>              Owner: platform_i386@kernel-bugs.osdl.org
>          Submitter: andreas.schnaiter@leo-computer.de
> 
> 
> Distribution: Slackware current     
>     
> Hardware Environment:      
>    CPU's (2x of course ^^):      
> processor       : 0     
> vendor_id       : GenuineIntel     
> cpu family      : 6     
> model           : 8     
> model name      : Pentium III (Coppermine)     
> stepping        : 6     
> cpu MHz         : 1004.521     
> cache size      : 256 KB     
> fdiv_bug        : no     
> hlt_bug         : no     
> f00f_bug        : no     
> coma_bug        : no     
> fpu             : yes     
> fpu_exception   : yes     
> cpuid level     : 2     
> wp              : yes     
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca     
> cmov pat pse36 mmx fxsrsse     
> bogomips        : 2005.40     
>      
>    other:     
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]     
> (rev c4)     
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x     
> AGP]     
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev     
> 40)     
> 00:04.1 IDE interface: VIA Technologies, Inc.     
> VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)     
> 00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev     
> 40)     
> 00:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)     
> 00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI     
> Adapter (rev 01)     
> 00:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI     
> Adapter (rev 01)     
> 00:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)     
> 00:0c.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)     
>     
>     
> Software Environment: (tested with)linux 2.4.27, 2.4.28, 2.6.7-2.6.10     
> (standard kernel.org, no extra patches)    
>     
>     
> Problem Description:     
>    I'll only post the exact error message and kernel config for 2.6.10 here,    
> since the message would probably grow too big with everything mentioned for    
> every version :)    
>   When booting with SMP enabled kernel the system hangs, always at the same    
> point:    
> ENABLING IO-APIC IRQs     
> (differnt wording with 2.4, but the same)    
>     
> The same occurs when booting a kernel without SMP enabled, but with the option    
> 'Local APIC support on uniprocessors' enabled.    
>     
> As soon as I compile without SMP and Local APIC support the system runs stable    
> at very high loads.    
>     
> the hardware seems ok, the box runs smooth with win2k, both CPU's work, (as 
> smooth as a win    
> contaminated box can run)    
>  
> I've found something similar in the kernel mailing list archives regarding 
> 2.4.18, but I believe the problem didn't get solved. 
>  
> please help me to help you further identify the problem =)
> 
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.
