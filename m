Return-Path: <linux-kernel-owner+w=401wt.eu-S1754854AbWL1Nvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbWL1Nvf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbWL1Nvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:51:35 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:37201 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853AbWL1Nve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:51:34 -0500
Message-ID: <4593CBD8.3020508@citd.de>
Date: Thu, 28 Dec 2006 14:51:20 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Loye Young <loyeyoung@iycc.net>
Cc: linux-kernel@vger.kernel.org,
       "James, <jsimmons@infradead.org>, loye.young@iycc.net, Simmons"@iycc.net
Subject: Re: The Input Layer and the Serial Port
References: <20061227235400.358E43FC065@hamlet.sw.biz.rr.com>
In-Reply-To: <20061227235400.358E43FC065@hamlet.sw.biz.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loye Young wrote:
>>Take for example the AT keyboard which is
>>one of the most common keyboards in the world. I have seen and
>>used it attached to a PC via parport, serial port and the standard
>>PS/2 port. So to handle cases like this the input layer created a
>>serio interface. 
> 
> 
> If plain ASCII text is coming in the serial port, would the kernel know or even care what device was generating the characters? Could I just use whatever interface you did?

A problem at this point may be that a AT-keyboard doesn't spit out ASCII
but Scan-Codes, so a serial device spitting out ASCII would have to be
put into the loop AFTER the stage that makes conversions, or you would
have to convert ASCII back to Scan-Codes before.

Btw. I'm not normaly into barcode-scanning, but for something at work i
tried a USB-scanner (From Symbol AFAIR) to see what is stored in the
barcodes that are on the prints that i have to generate. The scanner
just registered as a plain HID-device, which resulted in the data
comming as key-presses. It was just "Plug & Play", i didn't need any
software or anything else. I just plugged the device in, opened a
text-editor to catch the data, then i scanned the bar-codes and was
happy. :-)

So if you aren't nailed to a serial scanner, you just may try a USB-scanner.

>>I recommend you take a look at sermouse.c 
>>in the drivers/input.mouse directory
>>for a guide.
> 
> 
> I looked, but the source code I have (2.6.17, Debian) doesn't have anything called sermouse.c in the /drivers/input directory.

# find /usr/src/linux-2.6.19 -name "*sermouse*"
/usr/src/linux-2.6.19/drivers/input/mouse/sermouse.c





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

