Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUHJS55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUHJS55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUHJSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:55:29 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:64200 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267636AbUHJSvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:51:33 -0400
Message-ID: <41191929.4090305@free.fr>
Date: Tue, 10 Aug 2004 20:51:21 +0200
From: Eric Valette <eric.valette@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
References: <41189098.4000400@free.fr>  <4118A500.1080306@free.fr> <1092151779.5028.40.camel@dhcppc4>
In-Reply-To: <1092151779.5028.40.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

> asus_acpi.c from Karol
> http://linux-acpi.bkbits.net:8080/linux-acpi-test-2.6.7/gnupatch@4117a219yRjkVomavWT8WoMdRg7KHA
> 
> pci_link.c - resume fix from Nathan
> http://linux-acpi.bkbits.net:8080/linux-acpi-test-2.6.7/gnupatch@41114fe37ez5dnzmR96KT2DHr4-elA
> 
> I'll poke around the mm patch to see if anything else looks suspicious.

Thanks for answering Len. Due to the usual delay, I had the time to 
revert the paches myself before your answer and found that as expected 
the problem still persist (I browsed the patch quickly directly from 
bitkkeper acpi tree and found a priori nothing suspicious).

Curious that :
	- acpi=off boot option makes the problem vanish,
	- it looks like a deadlock due to an asynchronous event as it does not 
always occur at the same time after the boot finishes,
	- even without typing anything on the keyboard in single mode it deadlocks,
	- I never saw the fan suddenly wake-up (except of couse when 
temeratuire is too high) without a hard immediate reboot on this laptop. 
Here, during video (framebuffer) initialization, while the screen it 
still black they start spinning,

Will try andrew suggestion for the video-mode-handling-* patch

-- eric


