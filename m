Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTBET7i>; Wed, 5 Feb 2003 14:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBET7h>; Wed, 5 Feb 2003 14:59:37 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:65189 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264739AbTBET7e> convert rfc822-to-8bit; Wed, 5 Feb 2003 14:59:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide write barriers
Date: Wed, 5 Feb 2003 20:53:14 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Con Kolivas <conman@kolivas.net>
References: <20030205151859.GK31566@suse.de> <200302051628.48803.m.c.p@wolk-project.de> <20030205163352.GQ31566@suse.de>
In-Reply-To: <20030205163352.GQ31566@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302052047.11823.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 February 2003 17:33, Jens Axboe wrote:

Hi Jens,

> Sure, I had that one already. BTW, I discovered that the default io
thank you :)

> scheduler forgets to honor the cmd_flags, it's supposed to break like
> the noop does (see very first hunk in very first file). Must have
> removed that by mistake some time ago... This applies both to the
> 2.4.21-pre4 patch posted and this one.
well, I am impressed, really!

As you described in the patch:

+ *   For journalled file systems, doing ordered writes on a commit
+ *   block instead of explicitly doing wait_on_buffer (which is bad
+ *   for performance) can be a big win. Block drivers supporting this
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I don't have benchmarks handy yet but as far as I can _feel_, this is a _MUST_ 
(I repeat: a _MUST_ for 2.4.21). And I am very good in feeling slowdowns for 
interactivity :)

I am running it for quite some hours now with 2.4.20. Well, maybe the 
nr_requests = 16 and read/write passovers changes in the elevator code give 
us more smoothness than w/o but in my theoretical mind, this should drop 
throughput. I also noticed, these changes aren't in your 2.4.21 patch. Can 
you explain why it is in 2.4.20 patch or why it isn't in 2.4.21 patch ? :)

Thanks alot.

/ME calls out for Con to do a benchmark with the 2.4.21 patch.

ciao, Marc


