Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUKBTHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUKBTHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUKBTHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:07:41 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:30149 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261292AbUKBTHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:07:10 -0500
Message-ID: <4187DAB1.3010605@drzeus.cx>
Date: Tue, 02 Nov 2004 20:06:25 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __GFP flags and kmalloc failures
References: <4187AC80.6050409@drzeus.cx> <20041102144429.GG32054@logos.cnet> <4187CB93.6080405@drzeus.cx> <20041102152629.GH32054@logos.cnet> <4187D28B.5060507@drzeus.cx> <20041102155546.GJ32054@logos.cnet>
In-Reply-To: <20041102155546.GJ32054@logos.cnet>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Tue, Nov 02, 2004 at 07:31:39PM +0100, Pierre Ossman wrote:
>  
>
>>
>>Yes, I've browsed through these. __GFP_NOFAIL seems like it can hang for 
>>a very long time (I don't know if there is an upper bound on how long it 
>>will have to wait for a free page). __GFP_REPEAT seems to work good 
>>enough in this case.
>>My question was meant to be more along the lines of "Is there anything I 
>>can do without resorting to unstable/interal API:s?".
>>    
>>
>
>Not really. 
>
>They are not that unstable, I shouldnt mean that.
>
>These defines are not as stable as system calls - VM internals might change 
>in v2.7 and the flags also - but for v2.6 they are very likely to remain 
>untouched.
>
>Its just like any driver API in Linux - they change.
>
>Just keep an eye.
>  
>
Ok. I'll stick with __GFP_REPEAT for now then. If things break in the 
future it should be fairly obvious that this is the problem. Any users 
of the driver will probably point out that it's broken rather quickly :)

Thanks for the help!

Rgds
Pierre
