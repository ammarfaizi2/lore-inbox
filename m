Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbTCNESU>; Thu, 13 Mar 2003 23:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbTCNESU>; Thu, 13 Mar 2003 23:18:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263245AbTCNEST>;
	Thu, 13 Mar 2003 23:18:19 -0500
Message-ID: <33130.4.64.238.61.1047616146.squirrel@www.osdl.org>
Date: Thu, 13 Mar 2003 20:29:06 -0800 (PST)
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux@lundell-bros.com>
In-Reply-To: <p05210514ba96db3fb9e9@[10.2.0.101]>
References: <Pine.LNX.4.44.0303131522390.23207-100000@home.transmeta.com>
        <p05210514ba96db3fb9e9@[10.2.0.101]>
X-Priority: 3
Importance: Normal
Cc: <torvalds@transmeta.com>, <vonbrand@inf.utfsm.cl>, <rddunlap@osdl.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At 3:24pm -0800 3/13/03, Linus Torvalds wrote:
>>On Thu, 13 Mar 2003, Horst von Brand wrote:
>>>
>>>  No need. Just dump some bytes before EIP raw, plus raw bytes + decoded
>>> after EIP. Could be of some help.
>>
>>Alpha does this. Of course, there you don't have any of the partial
>> instruction issues.
>
> If you've got a symbol some reasonable distance before EIP, you could
> decode from there. I wrote a little code that does that (using
> kallsyms) very crudely in the stack trace in order to give the reader  a
> hint about stack frames. Go to the prior symbol, which is usually  an entry
> point, and find the %esp arithmetic. Works pretty well for  figuring out the
> real call chain.

as long as it's not a data symbol...
can you determine that?

~Randy



