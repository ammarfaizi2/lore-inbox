Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264759AbUEOWXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbUEOWXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUEOWXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:23:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264759AbUEOWXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:23:18 -0400
Message-ID: <40A69848.9020304@pobox.com>
Date: Sat, 15 May 2004 18:23:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][DOC] writing IDE driver guidelines
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040515173430.GA28873@havoc.gtf.org> <200405151958.03322.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405151958.03322.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 15 of May 2004 19:34, Jeff Garzik wrote:
>>On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>>- host drivers should request/release IO resource
>>>  themelves and set hwif->mmio to 2
>>
>>Don't you mean, hwif->mmio==2 for MMIO hardware?
> 
> 
> It is was historically for MMIO, now it means that driver
> handles IO resource itself (per comment in <linux/ide.h>).

Maybe then create a constant HOST_IO_RESOURCES (value==2) to make that 
more obvious?


>>>- define ide_default_irq(), ide_init_default_irq()
>>>  and ide_default_io_base() to (0)
>>
>>Maybe provide generic definitions, so that new arches don't even
>>have to care about this?
> 
> 
> Please explain.

Your document appears to imply that each new arch should define the 
above three symbols.

My suggestion is to devise a method by which new arches don't have to 
care about those symbols at all, unless required to do so by the 
underlying hardware.

	Jeff



