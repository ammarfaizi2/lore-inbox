Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272841AbTHEPDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272844AbTHEPCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:02:41 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:64250 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S272843AbTHEPCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:02:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Stephan von Krawczynski <skraw@ithnet.com>, root@chaos.analogic.com
Subject: Re: FS: hardlinks on directories
Date: Tue, 5 Aug 2003 10:02:04 -0500
X-Mailer: KMail [version 1.2]
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <Pine.LNX.4.53.0308050916140.5994@chaos> <20030805160435.7b151b0e.skraw@ithnet.com>
In-Reply-To: <20030805160435.7b151b0e.skraw@ithnet.com>
MIME-Version: 1.0
Message-Id: <03080510020503.05972@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 09:04, Stephan von Krawczynski wrote:
> On Tue, 5 Aug 2003 09:36:37 -0400 (EDT)
>
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > A hard-link is, by definition, indistinguishable from the original
> > entry. In fact, with fast machines and the course granularity of
> > file-system times, even the creation time may be exactly the
> > same.
>
> Hello Richard,
>
> I really don't mind if you call the thing I am looking for a hardlink or a
> chicken. And I am really not sticking to creating them by ln or mount or
> just about anything else. I am, too, not bound to making them permanent on
> the media. All I really want to do is to _export_ them via nfs.
> And guys, looking at mount -bind makes me think someone else (before poor
> me) needed just about the same thing.
> So, instead of constantly feeding my bad conscience, can some kind soul
> explain the possibilities to make "mount -bind/rbind" work over a network
> fs of some flavor, please?

Not sure, but I suspect there would be a problem IF the -bind mount crosses 
filesystems. If it doesn't cross the filesystems I wouldn't think there
would be much problem.

You do have to remember that any NFS export gives IMPLICIT access to the
entire filesystem (it is the device number that is actually exported). If
the attacker can generate device:inode number, then that file reference can
be opened. I haven't read/seen anything yet that has said different.
