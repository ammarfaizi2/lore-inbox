Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTHVHcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTHVHbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:31:40 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:28547 "EHLO
	boszi-lnx.localdomain") by vger.kernel.org with ESMTP
	id S263036AbTHVHCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:02:45 -0400
Message-ID: <3F45C012.9080903@freemail.hu>
Date: Fri, 22 Aug 2003 09:02:42 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to use an USB<->serial adapter?
References: <3F44BEA2.8010108@freemail.hu> <20030821170822.GA3584@kroah.com>
In-Reply-To: <20030821170822.GA3584@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 21, 2003 at 02:44:18PM +0200, Boszormenyi Zoltan wrote:
> 
>>Hi,
>>
>>I am experimenting with a Prolific USB<->RS232 adaptor. We have
>>in-house developments that need serial communication and there
>>are more and more mainboards that provide only one RS232 connector.
>>(We would need more in one machine...)
>>So we decided to try an usb-serial converter. The one we bought
>>was happily recognized by a RedHat 9 system but I couldn't get
>>two-way communication over this converter.
> 
> 
> Which kernel version are you using?

RH9 errata kernel 2.4.20-19.9, I also tried 2.6.0-test3-mm3.
On a sidenote, I also tried its driver on W98SE, WinXP.
Same result with the MinGW compiled test programs.

> I didn't run your test programs, but are you sure you got the hardware
> flow control settings correct?  How about testing the device with

Hmm, how comes the same settings *work* on real 16550?
Even under Win*, with the MinGW compiled testprograms...

> minicom, as that is a program that is known to work properly with these
> devices (along with lots of other ones, but that's a good place to
> start.)

I tried it now, thanks. Same thing happens. I set up two different
minirc, /etc/minirc.dfl using /dev/ttyS0 and /etc/minirc.usb
for /dev/ttyUSB0. In one terminal, I typed 'minicom', in another
'minicom usb'. In the 'minicom usb' what I type, appears in the
other window, but keys typed in the 'minicom' do not appear in
'minicom usb'.

I am starting to be convinced that it is a hardware flaw.
I will try to replace it.

>>setserial produces an error:
>>
>># setserial /dev/ttyUSB0
>>Cannot get serial info: Invalid argument
> 
> 
> Yes, setserial does not work with the majority of the usb-serial
> drivers, patches gladly accepted to fix this :)

I wasn't prepared to this answer. ;-)

> 
> thanks,
> 
> greg k-h

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

