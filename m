Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130414AbQKOAXA>; Tue, 14 Nov 2000 19:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbQKOAWu>; Tue, 14 Nov 2000 19:22:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129188AbQKOAWa>; Tue, 14 Nov 2000 19:22:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Re: test11-pre5
Date: 14 Nov 2000 15:51:50 -0800
Organization: Transmeta Corporation
Message-ID: <8usj6m$10i$1@penguin.transmeta.com>
In-Reply-To: <3A11C1B6.E61FF9F6@mandrakesoft.com> <Pine.LNX.4.21.0011150104250.26856-100000@callisto.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0011150104250.26856-100000@callisto.yi.org>,
Dan Aloni  <karrde@callisto.yi.org> wrote:
>On Tue, 14 Nov 2000, Jeff Garzik wrote:
>
>> Dan Aloni wrote:
>> > 
>> > reason: Correct me if I'm wrong, but 3c501.c:init_module() calls
>> > net_init.c:register_netdev(&dev_3c501), which calls strchr(),
>> > {and might also,which might} dereference dev_3c501.name.
>> 
>> There is no dereferencing involved, and therefore no problem.
>
>Well, at least I was alertive. Almost a bug fix ;-)
>Is there a special reason why dev->name is not a pointer?

It used to be.

And we used to have an incredible number of bugs with initialization and
with creating these things dynamically. A lot of Space.c was due to
horrible hackery with getting the static allocation right for these
things. Turning it into a plain array got rid of all the hackery, and
saved memory anyway.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
