Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWAOVS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWAOVS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWAOVS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:18:28 -0500
Received: from smtp-2.smtp.ucla.edu ([169.232.47.136]:65441 "EHLO
	smtp-2.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1750889AbWAOVS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:18:27 -0500
Date: Sun, 15 Jan 2006 13:18:20 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Roberto Nibali <ratz@drugphish.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20060115121242.GA20277@w.ods.org>
Message-ID: <Pine.LNX.4.64.0601151313590.5053@potato.cts.ucla.edu>
References: <20060105054348.GA28125@w.ods.org> <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
 <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch>
 <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch>
 <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu> <20060115121242.GA20277@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, Willy Tarreau wrote:
> On Sun, Jan 15, 2006 at 03:29:15AM -0800, Chris Stromsoe wrote:
>>
>> I've been running stable with the propsed changes since the 10th.  The 
>> original config and the currently running config are both at 
>> <http://hashbrown.cts.ucla.edu/pub/oops-200512/>.  This is the diff:
>>
>> cbs@hashbrown:~ > diff config-2.4.32 config-2.4.32-20060115
>>
>> 65c65
>> < CONFIG_HIGHIO=y
>> ---
>> > # CONFIG_HIGHIO is not set
>
> I wonder if this change could be suspected of affecting stability. With 
> this unset, data will be sent from the card to low memory, then bounced 
> to high mem when needed. Maybe the card, northbridge or anything else 
> sometimes corrupts memory during direct highmem I/O from PCI ? :-/

I'll let it run for another week as it is. If it would be useful 
information, I can switch CONFIG_HIGHIO back to =y and let that kernel run 
for a while.  Otherwise, I'll probably switch permanently to 2.6.


-Chris
