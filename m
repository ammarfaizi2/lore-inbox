Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTJMHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTJMHn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 03:43:29 -0400
Received: from madness.at ([213.153.61.104]:9230 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S261509AbTJMHn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 03:43:27 -0400
Message-ID: <3F8A5794.6030503@madness.at>
Date: Mon, 13 Oct 2003 09:43:16 +0200
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet> <200310092329.00445.bzolnier@elka.pw.edu.pl> <3F86746C.6040704@madness.at> <200310101127.43601.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310101127.43601.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Friday 10 of October 2003 10:57, Stefan Kaltenbrunner wrote:
> 
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>2.4.18, 2.4.19 w/o APIC and ACPI
>>
>>ok 2.4.18 (dmesg at http://www.kaltenbrunner.cc/files/dmesg2418.txt)
>>seems to work better(although not as fast as I would like to have it)
>>but I suspect that:
>>
>>ide1: Speed warnings UDMA 3/4/5 is not functional.
>>ide0: Speed warnings UDMA 3/4/5 is not functional.
>>
>>is quite interesting - if these UDMA-modes do not work reliable - why do
>>they get enabled with later kernels(not that I would have a problem with
>>getting UDMA > 2 working *g*) ?
> 
> 
> 2.4.22 has 80-pin cable dedetecion for more vendors.
> You can try passing "ide0=ata66 ide1=ata66" boot options.

tried that - worked well during the weekend (low io-traffic).
but today it broke again:


hda: dma_timer_expiry: dma status == 0x61
hda: error waiting for DMA
hda: dma timeout retry: status=0xd0 { Busy }

hda: DMA disabled
hdb: DMA disabled
ide0: reset: success
blk: queue c034db40, I/O limit 4095Mb (mask 0xffffffff)


more ideas to fix this ?

thanks

Stefan

