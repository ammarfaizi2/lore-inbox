Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbTGMPB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbTGMPB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:01:26 -0400
Received: from shinjuku.zaphods.net ([194.97.108.52]:7698 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S267401AbTGMPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:00:22 -0400
Message-ID: <3F11776B.8030506@zaphods.net>
Date: Sun, 13 Jul 2003 17:14:51 +0200
From: Stefan Schmidt <zaphodb@zaphods.net>
Reply-To: zaphodb@zaphods.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zaphodb@zaphods.net, ruben@puettmann.net
Subject: Re: 2.4.22-pre5 interrupts problem ?
References: <8O9v.3DF.11@gated-at.bofh.it>
In-Reply-To: <8O9v.3DF.11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann wrote:
> cat /proc/interrupts
>            CPU0       
>   0:     655923    IO-APIC-edge  timer
>   1:      22221    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          4    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:      33084    IO-APIC-edge  ide0
>  15:          3    IO-APIC-edge  ide1
>  18:  690660829   IO-APIC-level  aic7xxx, es1371
>  19:  686559334   IO-APIC-level  bttv, eth0
>  20:  683012480   IO-APIC-level  ehci_hcd, usb-ohci
>  22:     115606   IO-APIC-level  usb-ohci
> NMI:          0 
> LOC:     655895 
> ERR:          0
> MIS:          0
Hi, i am seeing the same behaviour of the Epox 8RDA3+ on 
2.4.22-pre5-vanilla.
Please note that only level-APICs seem to be affected.
We don't see these high interrupt rates anymore when APIC is disabled in 
the BIOS.
I also noted that the POST LED on the board flips between 94 and 96 
which it does not under WinXP where FF is displayed.
I have also a SATA Drive attached to the internal controller and under 
pre5 the box freezes if i do any serious amount of disk thoughput - for 
example using bonnie++. Maybe this is somehow related to this interrupt 
problem.
I experience freezes with current 2.5 kernels too.
WinXP is installed on the SATA Drive and rock stable, so this actually 
seems not to be a hardware problem per se.

> vmtstat 2
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  0  0      0 680320  35816 278576    0    0    30    66 1995   313 38  4 58  0
>  0  0      0 680316  35816 278576    0    0     0     0 322131     7  0  0 100  0

> Is this normal? 
If it were i would be desperate to hear why for my most frequented 
nameserver (>300queries/s) hardly even does 1000 interrupts/s. ;)

waves,
	Stefan

