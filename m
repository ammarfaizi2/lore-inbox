Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285427AbRLGHGC>; Fri, 7 Dec 2001 02:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285432AbRLGHFw>; Fri, 7 Dec 2001 02:05:52 -0500
Received: from smtp01.web.de ([194.45.170.210]:22545 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S285427AbRLGHFj>;
	Fri, 7 Dec 2001 02:05:39 -0500
Message-ID: <3C107838.1080702@web.de>
Date: Fri, 07 Dec 2001 08:05:12 +0000
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Weird SMC-IRCC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello alltogether,

The smc-ircc.o module behaves somewhat weird on my machine. Here is the 
data:
Dell Inspiron 8000
Debian GNU/Linux testing (aka sid)
kernel 2.4.16 compiled with
gcc version 2.95.4 20011006
SMC chip: LPC47N252

#----- snip (/var/log/messages) -----#
Dec  7 07:00:14 localhost kernel: found SMC SuperIO Chip (devid=0x0e 
rev=01 base=0x002e): LPC47N252
Dec  7 07:00:14 localhost kernel: SMC IrDA Controller found
Dec  7 07:00:14 localhost kernel:  IrCC version 2.0, firport 0x280, 
sirport 0x2f8 dma=3, irq=3
#---------- end snip ----------#

I managed to make the module load without problems after playing abit 
with the module options and including them finally in the modules.conf. 
So far, so good. The problem is that irdadump doesn't show anything 
except the host itself when I try to connect to my Nokia 6210 mobile phone.

Well, this up to the moment when I decided to give a shot to ACPI 
instead of APM. With all other options the same and only ACPI instead of 
APM the smc-ircc.o module finally started working, I was able to see my 
Nokia phone. Just to be sure I recompiled the kernel again with APM 
instead of ACPI and smc-ircc wasn't working. Another switch from APM to 
ACPI - and voilla - irda works.

So my question is: I would like irda working with APM and not only ACPI. 
ACPI is more advanced but still very experimental, and my laptop buttons 
(suspend, setup, etc) don't work with it. APM is still more robust and 
functional, I would like to stick with it. What should I do to resolve 
the problem? If anyone needs me to, I'd gladly include my 
$KERNELDIR/.config file or do anything else just to make irda working 
with APM.

Any help highly appreciated. Thanks in advance.
T.Todorov

