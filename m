Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSJJJfJ>; Thu, 10 Oct 2002 05:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbSJJJfJ>; Thu, 10 Oct 2002 05:35:09 -0400
Received: from denise.shiny.it ([194.20.232.1]:45192 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S263326AbSJJJfJ>;
	Thu, 10 Oct 2002 05:35:09 -0400
Message-ID: <XFMail.20021010113849.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20021010091000.GA16695@codepoet.org>
Date: Thu, 10 Oct 2002 11:38:49 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: Robert Love <rml@tech9.net>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The kernel already have cache pruning algorithm. O_STREAMING logic
>> should not clear caches if there is no need to do that. We could
>
> The entire point of O_STREAMING is to let user space specify
> policy.  If user space user space knows with 100% certainty that
> the data being read/written from a particular file descriptor is
> use-once-and-discard data, then it makes sense to honor that
> hint.  In this case, user space knows best and can set policy on
> a per file descriptor basis.

Yes, it makes sense, but it's useless or harmful to discard caches
if nobody else needs memory. You just lose data that may be
requested in the future for no reason.


Bye.

