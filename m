Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTKFKqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 05:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTKFKqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 05:46:00 -0500
Received: from data.iemw.tuwien.ac.at ([128.131.70.3]:7846 "EHLO
	data.iemw.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263522AbTKFKp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 05:45:58 -0500
Message-ID: <3FAA2653.9020002@tuwien.ac.at>
Date: Thu, 06 Nov 2003 11:45:39 +0100
From: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Organization: IEMW TU-Wien
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, de-at, cs
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: nforce2 random lockups - still no solution ?
References: <3F95748E.8020202@tuwien.ac.at> <200311060111.06729.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200311060111.06729.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>Now, in the system with MSI K7N2 motherboard I have a framegrabber
>>(Hauppauge PVR-250) installed, using ivtv driver.
>>I'm able to lock-up the system when streaming uncompressed video
>>(e.g. cat /dev/yuv0 >/dev/null) and the lockups are also hard, w/o
>>debug info. The ivtv driver is using DMA very heavily  but seems to
>>work on other chipsets. So these lock-up problems might be rather DMA
>>then APIC related. Interesting is that I've never had such a lock-up
>>when running WinXP on same computer ( :-) seems impossible), even
>>under load and with the framegrabber.
>>    
>>
>
>It can be a too-aggressive chipset configuration triggering chipset big.
>
>Maybe do lspci -vvvxxx and it's WinXP equivalent (I think such tool
>for Win ought to exist somewhere, although I had no need for it yet)
>and compare the result.
>--
>vda
>

It was local APIC ! After recompiling 2.4.22 without local apic 
everything works smoothly since several  weeks. I wonder when there'll 
be a kernel
patch that really solves these nforce2/amd issues.
Sam


