Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVDDImX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVDDImX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVDDImX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:42:23 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:35526 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261176AbVDDImP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:42:15 -0400
Message-ID: <4250FDE4.6090107@osvik.no>
Date: Mon, 04 Apr 2005 10:42:12 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: viro@parcelfarce.linux.theplanet.co.uk, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
References: <E1DIHww-0004bU-00@gondolin.me.apana.org.au>
In-Reply-To: <E1DIHww-0004bU-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>Dag Arne Osvik <da@osvik.no> wrote:
>  
>
>>>... and with such name 99% will assume (at least at the first reading)
>>>that it _is_ 32bits.  We have more than enough portability bugs as it
>>>is, no need to invite more by bad names.
>>>      
>>>
>>Agreed.  The way I see it there are two reasonable options.  One is to 
>>just use u32, which is always correct but sacrifices speed (at least 
>>with the current gcc).  The other is to introduce C99 types, which Linus 
>>doesn't seem to object to when they are kept away from interfaces 
>>(http://infocenter.guardiandigital.com/archive/linux-kernel/2004/Dec/0117.html).
>>    
>>
>
>There is a third option which has already been pointed out before:
>
>Use unsigned long.
>  
>

Yes, as Kulewski pointed out, unsigned long is at least 32 bits wide and 
therefore correct.  Whether it's also fastest is less of a concern, but 
it is so for at least the x86* architectures.  So, sure, I'll use it.

Cheers all,

-- 
  Dag Arne

