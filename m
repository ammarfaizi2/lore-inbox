Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUBFSDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbUBFSDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:03:40 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:22400 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S265560AbUBFSDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:03:36 -0500
Message-ID: <4023D6C6.70401@lbl.gov>
Date: Fri, 06 Feb 2004 10:02:46 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
References: <20040205014405.5a2cf529.akpm@osdl.org>
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting these:

irq 9: nobody cared!
Call Trace:
 [<c010c9e3>] __report_bad_irq+0x23/0x90
 [<c010cac8>] note_interrupt+0x58/0x90
 [<c010ce0b>] do_IRQ+0x16b/0x1a0
 [<c02cb138>] common_interrupt+0x18/0x20
 [<c026b30c>] sock_poll+0xc/0x20
 [<c0173a91>] do_pollfd+0x91/0xa0
 [<c0173aff>] do_poll+0x5f/0xc0
 [<c0173cf4>] sys_poll+0x194/0x2b0
 [<c0173080>] __pollwait+0x0/0xb0
 [<c015fc9a>] sys_write+0x4a/0x50
 [<c02ca1ba>] sysenter_past_esp+0x43/0x69

handlers:
[<c01cf136>] (acpi_irq+0x0/0x1a)
Disabling IRQ #9
[tdavis@lanshark tdavis]$ uname -a
Linux lanshark 2.6.2-mm1 #1 SMP Thu Feb 5 15:50:03 PST 2004 i686 athlon i386 GNU/Linux
[tdavis@lanshark tdavis]$ more /proc/interrupts
           CPU0       CPU1
  0:   27932291   27954246    IO-APIC-edge  timer
  1:        638        497    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
  9:      53744      46258    IO-APIC-edge  acpi
 12:       7867       7708    IO-APIC-edge  i8042
 14:      60366      50315    IO-APIC-edge  ide0
 15:       9026       7688    IO-APIC-edge  ide1
 18:     160500          1   IO-APIC-level  eth0
 19:        839        790   IO-APIC-level  ICE1712
NMI:          0          0
LOC:   55890040   55890045
ERR:          0
MIS:          0
