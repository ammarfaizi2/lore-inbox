Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937069AbWLDQTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937069AbWLDQTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937070AbWLDQTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:19:10 -0500
Received: from smtp.nokia.com ([131.228.20.170]:37443 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937069AbWLDQTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:19:08 -0500
Message-ID: <45744B3A.7050502@indt.org.br>
Date: Mon, 04 Dec 2006 12:22:18 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_omap_dma.diff
References: <4564648B.2020005@indt.org.br> <456805F3.1020407@drzeus.cx> <456AEB70.2000100@indt.org.br> <45709C93.7050709@drzeus.cx>
In-Reply-To: <45709C93.7050709@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 16:18:03.0735 (UTC) FILETIME=[C65A5670:01C717BF]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061204181811-1F552BB0-31720260/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> This patch is needed only for lock/unlock commands. So, it's necessary to
>> make MMC omap works when using that feature. It's not a generic patch.
>> But I can take off this one from the series and send after (if) the
>> series
>> is integrated.
>>
> 
> The patches are marked "[RFC]" which I interpret as that I shouldn't
> merge it. Is this incorrect?

Yes, you're right. But I believe this code is almost "ready" to be applied, do
you agree?
The next series I'll send without the "[RFC]" mark, what do you think?

> 
>> frame depends on data->blksz. When we were using data->blksz_bits
>> everything was
>> ok because we always had a multiple of 16 bits (2 bytes). Once a pwd
>> can has a size
>> not multiple of 2, the value must be rounded.
>> According to MMC OMAP Technical Reference Manual, because of each DMA
>> transfer is of
>> equal size, it is necessary to have the block size of the transfer be
>> a multiple of
>> the DMA write access size (which is 2 bytes).
>>
> 
> This sounds very generic and not something that is specific to the
> password command.

I'm still investigating where is the problem.
Actually this patch will not be included on the next series, as you
suggested. But it is still needed to make MMC lock/unlock works for
OMAP.

Best regards,

Anderson Briglia
