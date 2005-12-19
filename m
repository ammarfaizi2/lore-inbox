Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVLSH47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVLSH47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 02:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLSH47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 02:56:59 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:50151 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030275AbVLSH47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 02:56:59 -0500
Message-ID: <43A667F0.7080905@ru.mvista.com>
Date: Mon, 19 Dec 2005 10:57:36 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH 2.6-git 3/3] SPI core refresh: SPI/PNX bus driver and
 EEPROM driver
References: <20051215125800.4fa95de6.vwool@ru.mvista.com> <20051215130205.2ebdea18.vwool@ru.mvista.com> <20051215130354.5ca3d99f.vwool@ru.mvista.com> <200512181202.48218.david-b@pacbell.net>
In-Reply-To: <200512181202.48218.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>--- /dev/null
>>+++ linux-2.6.orig/drivers/spi/pnx4008-eeprom.c
>>@@ -0,0 +1,121 @@
>>...
>>+#define EEPROM_SIZE		256
>>+#define DRIVER_NAME		"EEPROM"
>>+#define READ_BUFF_SIZE 160
>>    
>>
>
>Wouldn't it be better to have an EEPROM driver that's not hard-wired
>to this particular devel board?  And which could work on at least all
>chips using eight bit addressing?
>
>This seems to match the 25020 series SPI EEPROMS.  (2 Kbits, 256 bytes.)
>But the 25010 and 25040 also use 8 bit address protoocol ... and then
>there are also chips using 16 bit addresses, and 24 bit ones.
>
>Shouldn't board init code be able to just say "25640 at spi1 chipselect 3",
>and have the driver know that means 8 KBytes with pagesize 32?
>
>  
>
Looks reasonable to me, thanks. Anyway - not today :)

Vitaly
