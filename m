Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313680AbSD3R5J>; Tue, 30 Apr 2002 13:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313747AbSD3R5J>; Tue, 30 Apr 2002 13:57:09 -0400
Received: from ns1.affordablehost.com ([206.104.238.105]:21951 "HELO
	callisto.affordablehost.com") by vger.kernel.org with SMTP
	id <S313680AbSD3R5I>; Tue, 30 Apr 2002 13:57:08 -0400
Message-ID: <3CCEDAF8.5030809@keyed-upsoftware.com>
Date: Tue, 30 Apr 2002 12:57:12 -0500
From: David Stroupe <dstroupe@keyed-upsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: printk in interrupt handler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackHole: Version 0.9.75 by Chris Kennedy (C) 2002
X-BlackHole-Sender: (null)
X-BlackHole-Relay: 12.238.66.88
X-BlackHole-Match: No Match
X-BlackHole-Info: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a device driver that responds to interrupts on my custom 
device.  I have a user-space application that talks to this driver.  I 
am debugging the user space code using gdb.  If I place a breakpoint in 
my user code at the first instruction that should be executed after 
receipt of an interrupt, I get my breakpoint.  Within my driver I have 
printk's placed in the handler and in the blocked read instruction that 
would give me additional info about the source of the interrupt, irq 
status register etc, byt these printk's never appear.  Obviously since 
the blocked I/O releases, these instructions must be getting executed. 
 Are these printk commands not flushed due to the debugger's influence? 
 Is there a way for me to flush them more quickly so that I may view 
them with dmesg (or looking at the messages file)?

TIA

-- 
Best regards,
David Stroupe
Keyed-Up Software


