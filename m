Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267477AbTGHPfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267479AbTGHPfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:35:33 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:30340 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267477AbTGHPf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:35:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 08:42:29 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0216@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030708154636.GM9328@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307080840400.4544@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
 <20030708154636.GM9328@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Eric Varsanyi wrote:

> On Mon, Jul 07, 2003 at 04:26:21PM -0700, Davide Libenzi wrote:
> > On Mon, 7 Jul 2003, Davide Libenzi wrote:
> > Try out this one, either over 2.5.74 or over an existing epoll-patched
> > 2.4.{20,21} ...
>
> This appears to be working as advertised, thanks!
>
> IMO it doesn't seem that evil to deliver events per-fd rather than
> per-file, this is similar to the semantic you get from select() on
> fd's sharing an object. To be surprised someone would have to have
> coded to the (previous) sharing visible nature of epoll and be expecting
> the EEXIST back when sharing was in play.

It is not that events are delivered per-fd. If 3 and 4 refer to the same
file* and you register both 3 and 4 with EPOLLIN, you'll get two events if
an EPOLLIN happen. One for 3 and one for 4.



- Davide

