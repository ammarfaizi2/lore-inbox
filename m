Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282547AbRKZVNL>; Mon, 26 Nov 2001 16:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282555AbRKZVMz>; Mon, 26 Nov 2001 16:12:55 -0500
Received: from [140.249.38.181] ([140.249.38.181]:33804 "EHLO
	neptune.cuseeme.com") by vger.kernel.org with ESMTP
	id <S282547AbRKZVMh>; Mon, 26 Nov 2001 16:12:37 -0500
Message-ID: <6A5AF4EA59EB214BB0267741CE2C86EF0E07F5@neptune.cuseeme.com>
From: Brian Raymond <braymond@fvc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Async UDP I/O?
Date: Mon, 26 Nov 2001 16:07:02 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking for some information on what the Linux kernel offers in
regard to async UDP traffic but haven't had much luck so I thought I would
throw this out to the list.

I work for a software company that make software MCUs (Multipoint control
units - Video Conferencing). In a pure sense they are simply media routers
which handle almost exclusively UDP traffic. We currently run under Linux,
Solaris and Windows but because of the lack of any real asynchronous UDP
mechanisms in Linux or Solaris we are getting the best performance on our
Windows boxes. There are a lot of *NIX guys around here (including me) who
don't like that Windows takes the cake. We are working with Sun on improving
the async UDP in Solaris 9 but haven't had any real success yet.

Currently we do the same thing in Linux that we do for Solaris; open up
threads for the UDP traffic and have them wait for the data. This obviously
leads to rather poor performance. I know a lot more about the specifics of
our Solaris issues but I assume they apply to Linux as well. Currently
Windows gives us the ability to send out packets asynchronously and then
report to us where the packets have gone. Along with that when data is
received it can be copied directly from the kernel to our app. For our other
OSes it needs to be copied into user space and then into our app.

I don't really know of any answers right now but I would love to hear back
from anyone about what we might be able to do with this. We don't have
nearly the resources we used to so we might be over looking some facilities
offered in the 2.4 kernel that weren't in the 2.2 so I would love to hear
anything.

Thanks,

Brian Raymond
