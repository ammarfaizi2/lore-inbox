Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268577AbTBZD0B>; Tue, 25 Feb 2003 22:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268622AbTBZD0B>; Tue, 25 Feb 2003 22:26:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268577AbTBZD0A>;
	Tue, 25 Feb 2003 22:26:00 -0500
Message-ID: <1707.4.64.238.61.1046230558.squirrel@www.osdl.org>
Date: Tue, 25 Feb 2003 19:35:58 -0800 (PST)
Subject: Re: [PATCH] eliminate warnings in generated module files
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rusty@rustcorp.com.au>
In-Reply-To: <20030226012305.A31342C158@lists.samba.org>
References: Your
        message
        of
        "Tue,
        25
        Feb
        2003
        15:47:59
        -0800."
        <20030226012305.A31342C158@lists.samba.org>
X-Priority: 3
Importance: Normal
Cc: <torvalds@transmeta.com>, <rth@twiddle.net>,
       <linux-kernel@vger.kernel.org>, <kai@tp1.ruhr-uni-bochum.de>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <Pine.LNX.4.44.0302251546590.2185-100000@home.transmeta.com> you
> wri te:
>>
>> On Tue, 25 Feb 2003, Rusty Russell wrote:
>> >
>> > __optional should always be __attribute__((__unused__)), and
>> > __required should be your __attribute_used__.
>>
>> But I think rth's point was that "__module_depends" should definitely
>> _not_ be "optional", since that just means that the compiler can (and
>> will) optimize away the whole thing.
>>
>> So marking it optional is definitely the wrong thing to do.
>
> This time for sure!
>
> Name: __optional attribute
> Author: Rusty Russell
> Status: Trivial

I have to agree with Kai and Milton Miller on this (bad) naming.
__required and __optional don't generate the corrent connotations
of what is being attempted here.

Milton suggesting spelling __attribute_used__ as __keep or
__needed.  I prefer __attribute_used__, but something like
__mark_as_used__ would be OK too.

And what uses __optional, however it is spelled?

Thanks,
~Randy




