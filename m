Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSIPIxM>; Mon, 16 Sep 2002 04:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbSIPIxM>; Mon, 16 Sep 2002 04:53:12 -0400
Received: from b070129.adsl.hansenet.de ([62.109.70.129]:2052 "EHLO
	smaug.lan.local") by vger.kernel.org with ESMTP id <S261238AbSIPIxL>;
	Mon, 16 Sep 2002 04:53:11 -0400
Message-ID: <XFMail.20020916105801.f.hinzmann@hamburg.de>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <200209141525.22349.jan-hinnerk_reichert@hamburg.de>
Date: Mon, 16 Sep 2002 10:58:01 +0200 (CEST)
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


On 14-Sep-2002 Jan-Hinnerk Reichert wrote:

> Florian Hinzmann wrote:

>> I have problems with DMA mode at one of my boxes ( more technical
>> details at the end of this mail ).
> [...] 
>> But I do issue a "hdparm -d0" for each of them at bootup currently and
>> they are running fine then. Enabling DMA with "hdparm -d1" (or not using
>> hdparm at all) leads to errors like the following quite fast and
>> reproducable:
>> 
>> kernel: hdb: dma_timer_expiry: dma status == 0x60
>> kernel: hdb: timeout waiting for DMA
>> kernel: hdb: timeout waiting for DMA
>> kernel: hdb: (__ide_dma_test_irq) called while not waiting
>> kernel: hdb: status error: status=0x58 { DriveReady SeekComplete
>> DataRequest } kernel:
>> kernel: hdb: drive not ready for command
>> 
>> Turning DMA off again stops these.
>> 
>> 
>> I'd love to hear any experience other people have with this mainboard
>> or even some statement if DMA is supposed to work with my setup.
> 
> I had some problems like this using 2.4.17 on a PIIX3 board (don't know the 
> board type). The problems disappeared after switching to 2.4.19. 
> Unforunately I had to change the processor and processor fan about the same 
> time.
> 
> I tend to believe that this problem was related to CPU temperature not to 

I don't think cpu temperature is the problem in my case. The fan is 
working well and the box is running stable with high load for hours/days
while there is no heavy disk activity. But copying files for some minutes 
kills it reliably.
But I will try to watch this more closely.  Might running the CPU with 
100MHz instead of 200MHz to keep it cooler be worth a try? I could try to 
find another CPU to put into my machine, too.


Greetings
     Florian



--
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65
