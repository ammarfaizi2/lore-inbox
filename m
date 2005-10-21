Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVJUJlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVJUJlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 05:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVJUJlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 05:41:47 -0400
Received: from gate.corvil.net ([213.94.219.177]:64015 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S964909AbVJUJlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 05:41:47 -0400
Message-ID: <4358B7CF.4010201@draigBrady.com>
Date: Fri, 21 Oct 2005 10:41:35 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ryan.clayburn@dsto.defence.gov.au
CC: linux-kernel@vger.kernel.org
Subject: Re: Advantech Watchdog timer query.
References: <1129880542.2194.49.camel@localhost.localdomain>
In-Reply-To: <1129880542.2194.49.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Clayburn wrote:
> Hi Everyone,
> 
> I work for a government agency so please forgive me for not having the
> latest version of the kernel. My question concerns an Advantech card PCI
> 6870 Single Board Computer and its watchdog timer. I am running Redhat 9
> linux 2.4.20-8 and it comes with module that supports the hardware
> advantechwdt.o. I have been able install and communicate with the card.
> Get and set the timeout or margin and get the support information of the
> card. Everything seems to work except when i deliberately delay the ping
> to the card to let it reboot the system as a watchdog should it does not
> reboot. Is there something i am missing. Do i need a update to the
> driver? I am attaching the code. It is fairly simple and a lot of it is
> just reading and writing information read from the driver about the
> card. I would appreciate any help.

Be careful that you're using the correct driver.
Certain newer advantech systems use the w83627hf
chip, which is not supported in 2.4 by default.
Backporting the driver from 2.6 should be trivial.

Pádraig.
