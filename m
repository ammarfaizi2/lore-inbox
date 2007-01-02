Return-Path: <linux-kernel-owner+w=401wt.eu-S965018AbXABXB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbXABXB4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbXABXB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:01:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47497 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965018AbXABXBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:01:55 -0500
Message-ID: <459AE459.8030107@pobox.com>
Date: Tue, 02 Jan 2007 18:01:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>	<459973F6.2090201@pobox.com>	<20070102115834.1e7644b2@localhost.localdomain>	<459AC808.1030807@pobox.com>	<20070102212701.4b4535cf@localhost.localdomain>	<459ACE9C.7020107@pobox.com> <20070102224559.2089d28d@localhost.localdomain>
In-Reply-To: <20070102224559.2089d28d@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>>> We use BAR5 on two devices in legacy mode. Both of those reserve all the
>>> other resources.
>> Translation:  You want to hand-wave away an obvious regression that YOU 
>> have created with your fix-to-a-fix.
> 
> It's not regressing anything.

False:

2.6.0 - 2.6.19:  libata guarantees that all PCI BARs are reserved to the 
libata driver.

2.6.20:  no guarantee that all PCI BARs are reserved to libata driver. 
Real-life ata_piix example already provided, where a PCI BAR is no 
longer reserved to the driver.

2.6.21 - infinity:  libata guarantees that all PCI BARs are reserved to 
the driver.

	Jeff


