Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVDCWsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVDCWsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 18:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVDCWsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 18:48:15 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:8376 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261939AbVDCWsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 18:48:07 -0400
Message-ID: <425072A4.7080804@osvik.no>
Date: Mon, 04 Apr 2005 00:48:04 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
References: <424FD9BB.7040100@osvik.no>	<20050403220508.712e14ec.sfr@canb.auug.org.au>	<424FE1D3.9010805@osvik.no> <jezmwgxa5v.fsf@sykes.suse.de>
In-Reply-To: <jezmwgxa5v.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:

>Dag Arne Osvik <da@osvik.no> writes:
>
>  
>
>>Yes, but wouldn't it be much better to avoid code like the following, 
>>which may also be wrong (in terms of speed)?
>>
>>#ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
>> #define fast_u32 u64
>>#else
>> #define fast_u32 u32
>>#endif
>>    
>>
>
>How about using just unsigned long instead?
>  
>

unsigned long happens to coincide with uint_fast32_t for x86 and x86-64, 
but there's no guarantee that it will on other architectures.  And, at 
least in theory, long may even provide less than 32 bits.

-- 
  Dag Arne

