Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbVKDKDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbVKDKDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVKDKDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:03:40 -0500
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:11433 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1161128AbVKDKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:03:39 -0500
Message-ID: <436B31DC.4020207@draigBrady.com>
Date: Fri, 04 Nov 2005 10:03:08 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ryan.clayburn@dsto.defence.gov.au
CC: linux-kernel@vger.kernel.org
Subject: Re: Advantech Watchdog timer query
References: <1131082306.2025.10.camel@localhost.localdomain>
In-Reply-To: <1131082306.2025.10.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Clayburn wrote:

>>Hi Everyone,
>
>
>>I work for a government agency so please forgive me for not having the
>>latest version of the kernel. My question concerns an Advantech card
>>PCI 6870 Single Board Computer and its watchdog timer. I am running
>>Redhat 9 linux 2.4.20-8 and it comes with module that supports the
>>hardware advantechwdt.o. I have been able install and communicate with
>>the card.Get and set the timeout or margin and get the support
>>information of the card. Everything seems to work except when i
>>deliberately delay the ping to the card to let it reboot the system as
>>a watchdog should it does not reboot. Is there something i am missing.
>>Do i need a update to the driver? I am attaching the code. It is fairly
>>simple and a lot of it is just reading and writing information read
>
>>from the driver about the card. I would appreciate any help.
>
>>>Be careful that you're using the correct driver.
>>>Certain newer advantech systems use the w83627hf
>>>chip, which is not supported in 2.4 by default.
>>>Backporting the driver from 2.6 should be trivial.
>
>
>>>Pádraig.
>
>
>I have backported the driver as suggested from 2.6 to 2.4 but that
>didn't help. I then got a fedora core 3 installation on a separate hard
>drive with kernel 2.6.9-1.667. the one thing that i found that is
>peculiar and looks like a bug is that the /usr/include/watchdog.h is not
>the same as the watchdog.h in the src directory. In any case even after
>copying the the header file across i was unable to get the watchdog to
>reset the OS. Is there something i am not doing?
>
Looking at the datasheet for this system,
gives the watchdog characteristics of
15sec - 127min timeout in steps of 30sec.
This is quite sophisticated and doesn't
match the original advantechwdt.c, w83627hf.c
or i810-tco.c. So you need to ask advantech
exactly what watchdog they're using on that system.

Pádraig.

