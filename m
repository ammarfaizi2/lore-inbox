Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262123AbSJJI2F>; Thu, 10 Oct 2002 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJJI2F>; Thu, 10 Oct 2002 04:28:05 -0400
Received: from denise.shiny.it ([194.20.232.1]:63621 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S262123AbSJJI2E>;
	Thu, 10 Oct 2002 04:28:04 -0400
Message-ID: <XFMail.20021010103336.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20021010032950.GA11683@codepoet.org>
Date: Thu, 10 Oct 2002 10:33:36 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: linux-kernel@vger.kernel.org, Mark Mielke <mark@mark.mielke.cc>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>, Robert Love <rml@tech9.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Oct-2002 Erik Andersen wrote:
> I don't think grep is a very good candidate for O_STREAMING.  I
> usually want the stuff I grep to stay in cache.  O_STREAMING is
> much better suited to applications like ogle, vlc, xine, xmovie,
> xmms etc since there is little reason for the OS to cache things
> like songs and movies you aren't likely to hear/see again any
> time soon.

The kernel already have cache pruning algorithm. O_STREAMING logic
should not clear caches if there is no need to do that. We could
fake the age of the pages loaded with O_STR to make the kernel
discard them earlier (oh, I SUPPOSE pages have an age to make
a lru replacement algorithm possible).


Bye.

