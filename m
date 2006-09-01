Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWIAPsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWIAPsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWIAPsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:48:31 -0400
Received: from pih-relay06.plus.net ([212.159.14.133]:62873 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S1751674AbWIAPsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:48:30 -0400
Message-ID: <44F85646.4030100@mauve.plus.com>
Date: Fri, 01 Sep 2006 16:48:22 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: madhu chikkature <crmadhu210@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SDIO card support in Linux
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com> <44F73E37.6030602@drzeus.cx>
In-Reply-To: <44F73E37.6030602@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> madhu chikkature wrote:
>> Hi,
>>
>> This is regarding the discussion going on in the list about the
>> support of SDIO cards in Linux. I read some discussion happening to
>> support SDIO cards using the existing Linux MMC core but I could not
>> figure out what would be the direction the community to support the
>> SDIO cards.
<snip>
>> With this, is it a fissible solution to have the MMC core do the
>> initialization part of the card by having the CMD sequence for SDIO
>> card (CMD5 and CMD3) in the mmc_setup sequence and maintain the SDIO
>> card list along with MMC/SD?
>>
> 
> SD mandates a star topology (just a single card per bus), so we'll just
> force a single card into the list. SD memory cards can actually work on
> a shared bus, SDIO can not. It's not a big problem in practice though.

Is this true in SD-1 bit mode, or SPI?
I see nothing on a quick read-through of the abbreviated SDIO spec 
precluding  this.
Of course, it'd mean wire-or'd interrupt lines.

