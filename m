Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVA2QIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVA2QIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVA2QIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:08:43 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:991 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262933AbVA2QIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:08:41 -0500
Message-ID: <41FBB500.80805@drzeus.cx>
Date: Sat, 29 Jan 2005 17:08:32 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org> <41FBAC44.9020502@drzeus.cx> <20050129155722.GA1320@infradead.org>
In-Reply-To: <20050129155722.GA1320@infradead.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Sat, Jan 29, 2005 at 04:31:16PM +0100, Pierre Ossman wrote:
>  
>
>>The problem was that the DMA API didn't work for x86_64 when I wrote the 
>>driver. I see now that it has been fixed.
>>isa_virt_to_bus still works even though CONFIG_ISA is not configured. So 
>>    
>>
>
>It may not exist at all.
>
>  
>
For i386 and x86_64 it's defined as virt_to_phys in asm/io.h without any 
#ifdef:s protecting it.
