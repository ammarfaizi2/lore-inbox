Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVA2PbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVA2PbX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVA2PbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:31:23 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:22494 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262927AbVA2PbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:31:19 -0500
Message-ID: <41FBAC44.9020502@drzeus.cx>
Date: Sat, 29 Jan 2005 16:31:16 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org>
In-Reply-To: <20050129150023.GA959@infradead.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>>Russell, please undo this patch. isa_virt_to_bus() is not dependent on 
>>>CONFIG_ISA. It causes problems on x86_64 platforms which cannot enable 
>>>ISA support.
>>>
>>>      
>>>
>
>Actually it is, x86_64 just refuses to set CONFIG_ISA despite having
>isa-like devices.
>
>Either way a new driver shouldn't use isa_virt_to_bus at all but rather
>use the proper DMA API and all those problems go away.
>
>  
>
The problem was that the DMA API didn't work for x86_64 when I wrote the 
driver. I see now that it has been fixed.
isa_virt_to_bus still works even though CONFIG_ISA is not configured. So 
I still think that the ISA dependency should be removed.
I'll move to the new API when I have the time to properly test it.

Rgds
Pierre

