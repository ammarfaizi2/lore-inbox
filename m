Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWBPLSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWBPLSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWBPLSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:18:30 -0500
Received: from ruault.com ([81.57.109.127]:2207 "EHLO ruault.com")
	by vger.kernel.org with ESMTP id S1751352AbWBPLS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:18:29 -0500
Message-ID: <43F45F7A.8090606@ruault.com>
Date: Thu, 16 Feb 2006 12:18:18 +0100
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
References: <43EF8388.10202@ruault.com>	<20060215185120.6c35eca2.akpm@osdl.org>	<43F44978.2050809@ruault.com>	<20060216103619.GI30182@vanheusden.com> <20060216024625.1b5dc77b.akpm@osdl.org>
In-Reply-To: <20060216024625.1b5dc77b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Folkert van Heusden <folkert@vanheusden.com> wrote:
>  
>
>>I noticed that altough -i says using dma, that -d tells me it really is
>> off.
>>    
>>
>
>Yup, `hdparm -i' tells you what the drive _can_ do, not what it's actually
>doing.
>
>  
>
here's what i have:

sudo /sbin/hdparm -d /dev/hdd
/dev/hdd:
 using_dma    =  1 (on)

sudo /sbin/hdparm -d /dev/hdc
/dev/hdc:
 using_dma    =  1 (on)

So it appears that both CDROM/DVDROM drives are using DMA, which
confirms what i was thinking (since the traceback i have is not the same
as the one Folker provided which clearly indicates that it happens
during a pio operation ).

-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C

