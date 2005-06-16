Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVFPPyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVFPPyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVFPPyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:54:22 -0400
Received: from [85.8.12.41] ([85.8.12.41]:40118 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261696AbVFPPyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:54:19 -0400
Message-ID: <42B1A08B.8080601@drzeus.cx>
Date: Thu, 16 Jun 2005 17:53:47 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA DMA controller hangs
References: <42987450.9000601@drzeus.cx> <1117288285.2685.10.camel@localhost.localdomain> <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx>
In-Reply-To: <42A3061C.7010604@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how do we solve this problem? We should do a master clear and then
enable channel 4 after a suspend. The question is where. I see three
possible places:

* In the suspend code in kernel/power.
* In the driver actually handling the suspend (ACPI/APM/etc.).
* Via the device layer by adding a device for the DMA controller.

Which would be the preferred solution?


Rgds
Pierre

