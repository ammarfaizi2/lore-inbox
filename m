Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVCAGm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVCAGm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVCAGm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:42:27 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:39907 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261263AbVCAGmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:42:01 -0500
Message-ID: <42240EB3.6040504@andrew.cmu.edu>
Date: Tue, 01 Mar 2005 01:41:55 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex>	<42232DFC.6090000@andrew.cmu.edu> <87mzto3c78.fsf@bytesex.org>
In-Reply-To: <87mzto3c78.fsf@bytesex.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the hints.  Unfortunately the cards in question really are 
fairly generic and thus don't appear in the list.  I tried the first 75 
cards as insmod options (using a script of course), and some of them are 
different, but none work properly.

I am lucky in that I still have a spare.  If you could suggest a very 
well tested kernel for bttv (2.6.9?), I can set up another machine with 
that kernel and the remaining card.  That should allow me to isolate the 
problem better.  At the very least  I could get the right card= option 
to use for the broken pair.  Hopefully I will be able to generate a 
table entry for this card for bttv-cards.c;  I'll look some more at this 
tomorrow.

I've heard that there is some way to dump eeproms; Is there a way to 
write them also?  If I could copy the eeprom from the unused cards to 
the (now broken) pair that might fix things.

Thanks,
   Jim

Gerd Knorr wrote:
> James Bruce <bruce@andrew.cmu.edu> writes:
> 
>>Well, are there any theories as to why it would work flawlessly, then
>>after a hard lockup (due to what I think is a buggy V4L2 application),
>>that the cards no longer work?
> 
> No idea why the eeprom doesn't respond any more.  Maybe it's really
> broken.  Note that the eeprom is read only at insmod time (and even
> that for some cards only), thus there isn't a clear connection between
> the crash and the eeprom issue.  It could have died earlied unnoticed.
> 
> The eeprom holds the PCI Subsystem ID, so without a working eeprom
> bttv can't figure automatically what exact card that is (see the
> "unknown/default" card name in the log) and maybe thats why does not
> work any more for the card in question.  Thats should be easily
> fixable using the card= insmod option.
> 
>   Gerd
