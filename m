Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbSJJKfn>; Thu, 10 Oct 2002 06:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSJJKfn>; Thu, 10 Oct 2002 06:35:43 -0400
Received: from news.cistron.nl ([62.216.30.38]:15885 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S262290AbSJJKfn>;
	Thu, 10 Oct 2002 06:35:43 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Date: Thu, 10 Oct 2002 10:40:56 +0000 (UTC)
Organization: Cistron
Message-ID: <ao3lfo$42m$1@ncc1701.cistron.net>
References: <20021010091000.GA16695@codepoet.org> <XFMail.20021010113849.pochini@shiny.it>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1034246456 4182 62.216.29.67 (10 Oct 2002 10:40:56 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <XFMail.20021010113849.pochini@shiny.it>,
Giuliano Pochini  <pochini@shiny.it> wrote:
>>> The kernel already have cache pruning algorithm. O_STREAMING logic
>>> should not clear caches if there is no need to do that. We could
>>
>> The entire point of O_STREAMING is to let user space specify
>> policy.  If user space user space knows with 100% certainty that
>> the data being read/written from a particular file descriptor is
>> use-once-and-discard data, then it makes sense to honor that
>> hint.  In this case, user space knows best and can set policy on
>> a per file descriptor basis.
>
>Yes, it makes sense, but it's useless or harmful to discard caches
>if nobody else needs memory. You just lose data that may be
>requested in the future for no reason.

But to cache the DVD you will have to throw out the data which
is already there for no reason, and that is exactly what you
want to avoid.

At least on my machine buffers/cache _always_ fill up all free
memory. I don't want the streaming DVD to push that out.

Mike.

