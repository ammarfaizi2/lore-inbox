Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbVKDFjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbVKDFjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVKDFjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:39:16 -0500
Received: from digger1.defence.gov.au ([203.5.217.4]:45046 "EHLO
	digger1.defence.gov.au") by vger.kernel.org with ESMTP
	id S1161055AbVKDFjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:39:15 -0500
Subject: Re: Advantech Watchdog timer query
From: Ryan Clayburn <ryan.clayburn@dsto.defence.gov.au>
Reply-To: ryan.clayburn@dsto.defence.gov.au
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Organization: dsto
Message-Id: <1131082306.2025.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Nov 2005 16:01:47 +1030
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Everyone,

>I work for a government agency so please forgive me for not having the
>latest version of the kernel. My question concerns an Advantech card
>PCI 6870 Single Board Computer and its watchdog timer. I am running
>Redhat 9 linux 2.4.20-8 and it comes with module that supports the
>hardware advantechwdt.o. I have been able install and communicate with
>the card.Get and set the timeout or margin and get the support
>information of the card. Everything seems to work except when i
>deliberately delay the ping to the card to let it reboot the system as
>a watchdog should it does not reboot. Is there something i am missing.
>Do i need a update to the driver? I am attaching the code. It is fairly
>simple and a lot of it is just reading and writing information read
>from the driver about the card. I would appreciate any help.

>>Be careful that you're using the correct driver.
>>Certain newer advantech systems use the w83627hf
>>chip, which is not supported in 2.4 by default.
>>Backporting the driver from 2.6 should be trivial.

>>Pádraig.

I have backported the driver as suggested from 2.6 to 2.4 but that
didn't help. I then got a fedora core 3 installation on a separate hard
drive with kernel 2.6.9-1.667. the one thing that i found that is
peculiar and looks like a bug is that the /usr/include/watchdog.h is not
the same as the watchdog.h in the src directory. In any case even after
copying the the header file across i was unable to get the watchdog to
reset the OS. Is there something i am not doing?

Cheers

Ryan


