Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTD1BbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTD1BbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:31:24 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:31254 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263241AbTD1BbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:31:23 -0400
Date: Sun, 27 Apr 2003 21:43:38 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.LNX.4.53.0304271831250.8792@twinlark.arctic.org>
Message-ID: <Pine.BSO.4.44.0304272140340.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, dean gaudet wrote:

> On Sun, 27 Apr 2003, Mark Grosberg wrote:
>
> > I would think on large, multi-user systems that are spawning processes all
> > day, this might improve performance if the shells on such a system were
> > patched.
>
> more relevant is a large multithreaded (or async model with many
> connections per thread/process) webserver spawning cgi.  otherwise you pay

Heh. I just happen to have written a multi-threaded webserver (called
Seminole), but it does CGI "in process." Actually, it runs on VxWorks too
where there is no concept of a process. :-)

But you're right. This could be a boon for any non-in-process (non
mod_perl or PHP) webservers.

The idea would be that the file mapping array would be easier to scan
(kind of like how poll() is a lot easier than select()).

> if you look at such webservers they tend to have a separate process just
> for the purpose of spawning cgi/etc. and use some IPC to pass the data to
> the cgi spawner.

Yup. I suppose for Apache this could be an alternate interface of the APR
spawn process function.

L8r,
Mark G.

