Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270206AbRH1UzL>; Tue, 28 Aug 2001 16:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRH1UzB>; Tue, 28 Aug 2001 16:55:01 -0400
Received: from mail.lightning.ch ([193.247.134.3]:54021 "HELO
	mail.lightning.ch") by vger.kernel.org with SMTP id <S270206AbRH1Uyw>;
	Tue, 28 Aug 2001 16:54:52 -0400
Message-ID: <3B8C0475.6050103@lightning.ch>
Date: Tue, 28 Aug 2001 22:52:05 +0200
From: Jean-Christian de Rivaz <jcdr@lightning.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Treating parallel port as serial device
In-Reply-To: <9mgtpb$mf4$1@sisko.my.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look to the MAX3100 chip:
http://pdfserv.maxim-ic.com/arpdf/MAX3100.pdf

This solution highly reduce the CPU overhead needed to sample Rx line 
for each single bit. The chip have a FIFO, an interrupt and look like a 
standard UART. Only the bus transfert with the CPU is different.

I curently work on a driver for it.

Regards,

Tony Hoyle wrote:
> I'm looking to attach a serial device to my box that has only TTL level
> I/O.  Since I'm more of a software than a hardware person making a
> circuit board up with a max232 in is a bit risky...  I want to connect
> the I/O to the parallel port.
> 
> What I need now is a driver that can read the input from a  pin on the
> parallel port and treat it as serial input.  It sounds like the kind of
> project that would have been done before, but I can't find anything that
> even comes close.  Userspace probably wouldn't cut it as I'm reading as
> 9600 baud and usleep doesn't have nearly enough resolution.
> 
> Tony
> 
> 



