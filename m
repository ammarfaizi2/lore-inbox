Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWJXNKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWJXNKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWJXNKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:10:20 -0400
Received: from pxy2nd.nifty.com ([202.248.175.14]:58931 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S1161072AbWJXNKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=noJIy3/8BmBgsENpsUi542CApKp+T349lxOkGUwJQNa+B3YETZ1HjZ/p4Q2CFRQgCWzDD10v3C2gfiidPna6sA==  ;
Message-ID: <23488566.296101161695417305.komurojun-mbn@nifty.com>
Date: Tue, 24 Oct 2006 22:10:17 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: tglx@linutronix.de
Subject: Re: Re: [2.6.19-rc1   APIC BUG?] kernel 2.6.19-rc1 or later can not generate ISA irq properly on DUAL-CPU system.
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1161615339.22373.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <1161615339.22373.30.camel@localhost.localdomain>
 <20061022162948.1cf26ad6.komurojun-mbn@nifty.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> kernel 2.6.19-rc1 or later can not generate ISA irq properly on DUAL-CPU sy
stem.
>> kernel 2.6.18 work properly.
>> 
>> I think this problem is caused by IRQ-subsystem change on 2.6.19-rc1.
>
>I have to wait until tomorrow until I get access to a system with ISA
>network card.
>
>> Please advise.
>
>Does the box boot into login ? If yes, can you please provide the output
>of /proc/interrupts ?
>

Here is the output of /proc/interrupts

I found some interrupt-count in IRQ 3.
but if I do the ping command, the IRQ 3 interrupt-count
is not incremented.

I tried several 16bit-pcmcia network card.
 (1)Asix 100Mbps   PCMCIA Network card => does not work
 (2)DL10019 100Mpbs PCMCIA Network card => does not work
 
 (3)NE2000-based 10Mbps PCMCIA Network card => works properly.


           CPU0       CPU1       
  0:       9051      10701   IO-APIC-edge     timer
  1:        122        135   IO-APIC-edge     i8042
  2:          0          0    XT-PIC-level    cascade
  3:          8          6   IO-APIC-edge     axnet_cs   <=
  6:          3          2   IO-APIC-edge     floppy
  8:          1          0   IO-APIC-edge     rtc
 12:         91         14   IO-APIC-edge     i8042
 14:        902       1173   IO-APIC-edge     ide0
 15:          1          1   IO-APIC-edge     i82365
NMI:          0          0 
LOC:      19682      19681 
ERR:          0
MIS:          0

Best Regards
Komuro


