Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWJEP4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWJEP4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWJEP4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:56:19 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:35471 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751632AbWJEP4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:56:18 -0400
Message-ID: <45252B12.9010206@drzeus.cx>
Date: Thu, 05 Oct 2006 17:56:02 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: philipl@alumni.utexas.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 2/2] mmc: Read mmc v4 EXT_CSD
References: <15151.67.169.45.37.1159744878.squirrel@overt.org> <4522A2DD.9080803@drzeus.cx> <45232302.1050007@overt.org>
In-Reply-To: <45232302.1050007@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> Pierre,
>
> I will reorganise these patches into a series that detects and sets up
> high-speed support. This is pretty simple. Wide-bus is harder because
> you have to run their weird test pattern and check all the power class
> stuff. Hopefully I'll have that done this week.
>   

Goodie. Have these patches seen any wide spread testing?

> Pierre Ossman wrote:
>   
>> philipl@overt.org wrote:
>>     
>>> +	list_for_each_entry(card, &host->cards, node) {
>>> +		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
>>> +			continue;
>>>   
>>>       
>> Please use the macros.
>>     
>
> I'm confused: mmc_read_scrs and mmc_read_csds use this exact same
> construction in 2.6.18 and Linus' current tree. Should I be checking
> another tree?
>
>   

Nah, they're also wrong. Patches welcome ;)

Rgds
Pierre

