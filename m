Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSKWTxk>; Sat, 23 Nov 2002 14:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSKWTxk>; Sat, 23 Nov 2002 14:53:40 -0500
Received: from [203.199.93.15] ([203.199.93.15]:6923 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S267065AbSKWTxj>; Sat, 23 Nov 2002 14:53:39 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200211231954.BAA23235@WS0005.indiatimes.com>
To: "Manfred Spraul" <manfred@colorfullife.com>
CC: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Re: Re: switching to interrupt contex when no interrupts
Date: Sun, 24 Nov 2002 01:33:21 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  
<<What do you want to do?
>>I want to simulate a PCI based controller and its behaviour, interrupts,etc..
I want to simulate the interrupts in sequence and want to process them in my driver software.

<<local_irq_save()/local_irq_restore() temporarily disable the interrupt 
>>My requirement is to simulate interrupts and not to disable interrupts.
  
Thanks & Warm Regards
Arun

"Manfred Spraul" wrote:



&gt;
&gt;
&gt; I'd like to force my kernel module to run at interrupt context at some specific \
&gt;points/time and then come back from interrrupt contex after executing that particular \
&gt;portion of code..
&gt; 
&gt;
What do you want to do?
local_irq_save()/local_irq_restore() temporarily disable the interrupt 
processing of the current cpu. Note that other cpus in the system 
continue to handle interrupts.
disable_irq(x) disables the interrupt processing for the interrupt line x.
For example, my network drivers use disable_irq() to synchronize 
interrupt processing and error recovery.

--
Manfred




Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

