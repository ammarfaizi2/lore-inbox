Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSGaBRr>; Tue, 30 Jul 2002 21:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSGaBRr>; Tue, 30 Jul 2002 21:17:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64270 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317537AbSGaBRq>; Tue, 30 Jul 2002 21:17:46 -0400
Date: Tue, 30 Jul 2002 22:20:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: async-io API registration for 2.5.29
In-Reply-To: <20020730214116.GN1181@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0207302219400.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Andrea Arcangeli wrote:
> On Tue, Jul 30, 2002 at 08:49:39AM -0400, Benjamin LaHaise wrote:
> > On Tue, Jul 30, 2002 at 07:41:11AM +0200, Andrea Arcangeli wrote:

> > What would you suggest as an alternative API?  The main point of multiplexing
> > is that ios can be submitted in batches, which can't be done if the ios are
> > submitted via individual syscalls, not to mention the overlap with the posix
> > aio api.
>
> yes, sys_io_sumbit has the advantage you can mix read/write/fsync etc..
> in the same array of iocb. But by the same argument we could as well
> have a submit_io instead of sys_read/sys_write/sys_fsync.

You can't batch synchronous requests, so your "by the same
argument" doesn't work.

Asynchronous requests, OTOH, could be submitted in large
bundles since the app doesn't wait on each request.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

