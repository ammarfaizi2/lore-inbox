Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVDDKuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVDDKuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVDDKuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:50:14 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:9864 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261213AbVDDKuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:50:04 -0400
Message-ID: <42511BD8.4060608@osvik.no>
Date: Mon, 04 Apr 2005 12:50:00 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Renate Meijer <kleuske@xs4all.nl>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Kenneth Johansson <ken@kenjo.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Grzegorz Kulewski <kangur@polcom.net>, Andreas Schwab <schwab@suse.de>
Subject: Re: Use of C99 int types
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl>
In-Reply-To: <3821024b00b47598e66f504c51437f72@xs4all.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renate Meijer wrote:

>
> On Apr 4, 2005, at 12:08 AM, Kyle Moffett wrote:
>
>> On Apr 03, 2005, at 16:25, Kenneth Johansson wrote:
>>
>>> But is this not exactly what Dag Arne Osvik was trying to do ??
>>> uint_fast32_t means that we want at least 32 bits but it's OK with
>>> more if that happens to be faster on this particular architecture.
>>> The problem was that the C99 standard types are not defined anywhere
>>> in the kernel headers so they can not be used.
>>
>>
>> Uhh, so what's wrong with "int" or "long"?
>

Nothing, as long as they work as required.  And Grzegorz Kulewski 
pointed out that unsigned long is required to be at least 32 bits, 
fulfilling the present need for a 32-bit or wider type.

>
> My point exactly, though I agree with Kenneth that adding the C99 types
> would be a Good Thing.


If it leads to better code, then indeed it would be.  However, Al Viro 
disagrees and strongly hints they would lead to worse code.

>
>> GCC will generally do the right thing if you just tell it "int".
>
>
> And if you don't, you imply some special requirement, which, if none 
> really exists, is
> misleading.


And in this case there is such a requirement.  Anyway, I've already 
decided to use unsigned long as a replacement for uint_fast32_t in my 
implementation.

-- 
  Dag Arne

