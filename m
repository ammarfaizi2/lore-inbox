Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTGHQ7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTGHQ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:59:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:52356 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264893AbTGHQ7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:59:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 10:06:46 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0216@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030708160206.GP9328@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307081005500.4792@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
 <20030708154636.GM9328@srv.foo21.com> <Pine.LNX.4.55.0307080840400.4544@bigblue.dev.mcafeelabs.com>
 <20030708160206.GP9328@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Eric Varsanyi wrote:

> On Tue, Jul 08, 2003 at 08:42:29AM -0700, Davide Libenzi wrote:
> > It is not that events are delivered per-fd. If 3 and 4 refer to the same
> > file* and you register both 3 and 4 with EPOLLIN, you'll get two events if
> > an EPOLLIN happen. One for 3 and one for 4.
>
> Agreed 100%, this is roughly what would happen with select() as well which
> IMO is good (not surprising behaviour) for event loop writers: it would
> return with both bits set. The EEXIST we were getting before this patch
> would be analogous to select() returning an error if you set 2 bits that
> where for fd's sharing an object (even across read/write bit vectors).
>
> One could argue at the logic of having 2 fd's get read events on a
> shared underlying object, but one read and the other write certainly
> makes sense as discussed earlier.

I did not have the time to test the patch in your scenario, but if you can
confirm me it is working fine I'll push it.


- Davide

