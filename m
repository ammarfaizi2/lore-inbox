Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWJDC5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWJDC5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWJDC5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:57:55 -0400
Received: from usul.saidi.cx ([204.11.33.34]:53655 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S1030729AbWJDC5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:57:54 -0400
Message-ID: <45232302.1050007@overt.org>
Date: Tue, 03 Oct 2006 19:57:06 -0700
From: Philip Langdale <philipl@overt.org>
Reply-To: philipl@alumni.utexas.net
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 2/2] mmc: Read mmc v4 EXT_CSD
References: <15151.67.169.45.37.1159744878.squirrel@overt.org> <4522A2DD.9080803@drzeus.cx>
In-Reply-To: <4522A2DD.9080803@drzeus.cx>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre,

I will reorganise these patches into a series that detects and sets up
high-speed support. This is pretty simple. Wide-bus is harder because
you have to run their weird test pattern and check all the power class
stuff. Hopefully I'll have that done this week.

Pierre Ossman wrote:
> philipl@overt.org wrote:
>> +	list_for_each_entry(card, &host->cards, node) {
>> +		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
>> +			continue;
>>   
> 
> Please use the macros.

I'm confused: mmc_read_scrs and mmc_read_csds use this exact same
construction in 2.6.18 and Linus' current tree. Should I be checking
another tree?

Will address all other comments.

Thanks,

--phil
