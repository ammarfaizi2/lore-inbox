Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbSKWTrc>; Sat, 23 Nov 2002 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSKWTrc>; Sat, 23 Nov 2002 14:47:32 -0500
Received: from [203.199.93.15] ([203.199.93.15]:49160 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S267039AbSKWTrb>; Sat, 23 Nov 2002 14:47:31 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200211231948.BAA22590@WS0005.indiatimes.com>
To: "John K Luebs" <jkluebs@luebsphoto.com>
CC: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Re: Re: switching to interrupt contex when no interrupts
Date: Sun, 24 Nov 2002 01:27:14 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

<<One is forced to run in interrupt context in an
interrupt handler. 
>>Yes. But my requirement is to force my code to run in interrupt context.

<<Possibility is undefined here because what you said makes no sense.

You will get a better answer from the list if you describe what you are trying to do (in concrete terms), not how you think you might do it.

>>My requirement is to simulate a PCI based controller and its behaviour in software. I knew the different type of interrupts and the timings my device produces. 

I need to simulate this PCI device, its interrupts in sequence and I have to process them in my driver software.

  Hope this make sense now.

  Anyway, my requrirement is to simulate the interrupts and process them in the interrupt context.

  It would be helpful, if anyone could help me how to do it. 
  My idea is to use task queues and bottom halves for this. But I'd like to get clarified on simulating interrupts (rasing the process/task context to interrupt context) and its consequences.
  
  
Thanks & Warm Regards
Arun


"John K Luebs" wrote:



On Sat, Nov 23, 2002 at 07:37:33AM +0530, arun4linux wrote:
&gt; Hello,
&gt; 
&gt; I'd like to force my kernel module to run at interrupt context at some specific points/time and then come back from interrrupt contex after executing that particular portion of code..

You seem to be over complexifying what interrupt context is. It is
simply a generic term for a context that executes on account of an
architecture interrupt. One is forced to run in interrupt context in an
interrupt handler. 

You "run" in interrupt context by calling request_irq attached to the
interrupt line that you are interested in installing a handler for.

&gt; 
&gt; Is it possible?

Possibility is undefined here because what you said makes no sense.

You will get a better answer from the list if you describe what you are
trying to do (in concrete terms), not how you think you might do it.




Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

