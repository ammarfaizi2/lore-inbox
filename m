Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWHXUgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWHXUgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWHXUgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:36:31 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:45975 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S965077AbWHXUga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:36:30 -0400
Message-ID: <44EE0DDA.5060600@cfl.rr.com>
Date: Thu, 24 Aug 2006 16:36:42 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Aleksey Gorelov <dared1st@yahoo.com>
CC: arjan@infradead.org, jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
Subject: Re: Generic Disk Driver in Linux
References: <20060824194012.77909.qmail@web83101.mail.mud.yahoo.com>
In-Reply-To: <20060824194012.77909.qmail@web83101.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2006 20:36:40.0834 (UTC) FILETIME=[01213E20:01C6C7BD]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14648.003
X-TM-AS-Result: No--7.081900-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The int 13 calls to the bios can only accept addresses within the first 
1 MB of memory, and the calls are synchronous, so DMA really doesn't 
matter as the cpu will be busy waiting anyhow while the IO takes place, 
which will wreak all kinds of hell on the rest of the running system, 
including other hardware ISRs.


Aleksey Gorelov wrote:
>> thing will be really really bad... (hint: real mode can access only 1Mb
>> of memory, so you will bounce buffer all IO's)
> This is true for non-dma case only. As I already mentioned before, most BIOSes 
> support dma, and there is no 1Mb limit for that (at least on modern hw).
> 
> Aleks.

