Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVDDUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVDDUun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDDUc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:32:56 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:56327 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S261386AbVDDUZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:25:17 -0400
In-Reply-To: <42511BD8.4060608@osvik.no>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c3057294a216d19047bdca201fc97e2f@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Andreas Schwab <schwab@suse.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Kenneth Johansson <ken@kenjo.org>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: Use of C99 int types
Date: Mon, 4 Apr 2005 22:30:52 +0200
To: Dag Arne Osvik <da@osvik.no>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 4, 2005, at 12:50 PM, Dag Arne Osvik wrote:

> Renate Meijer wrote:
>
>>
>> On Apr 4, 2005, at 12:08 AM, Kyle Moffett wrote:
>>
>>> On Apr 03, 2005, at 16:25, Kenneth Johansson wrote:
>>>
>>>> But is this not exactly what Dag Arne Osvik was trying to do ??
>>>> uint_fast32_t means that we want at least 32 bits but it's OK with
>>>> more if that happens to be faster on this particular architecture.
>>>> The problem was that the C99 standard types are not defined anywhere
>>>> in the kernel headers so they can not be used.
>>>
>>>
>>> Uhh, so what's wrong with "int" or "long"?
>>
>
> Nothing, as long as they work as required.  And Grzegorz Kulewski 
> pointed out that unsigned long is required to be at least 32 bits, 
> fulfilling the present need for a 32-bit or wider type.

>> My point exactly, though I agree with Kenneth that adding the C99 
>> types
>> would be a Good Thing.
>
>
> If it leads to better code, then indeed it would be.

At least a 32 bit integer is guaranteed to stay an 32 bit integer 
(should one be required)
though multiple incarnations of the compiler.

>   However, Al Viro disagrees and strongly hints they would lead to 
> worse code.

When used improperly. The #define Al Viro objected to, is 
objectionable. It's highly
misleading, as Mr. Viro pointed out. I fail to see where he made 
comments on stdint.h
as such.

>> And if you don't, you imply some special requirement, which, if none 
>> really exists, is
>> misleading.
>
> And in this case there is such a requirement.

Apart from the integer having 32 bits?

>   Anyway, I've already decided to use unsigned long as a replacement 
> for uint_fast32_t in my implementation.

Ok. I can live with that.

Regards,

Renate Meijer. 

