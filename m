Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316995AbSFQUdO>; Mon, 17 Jun 2002 16:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFQUcU>; Mon, 17 Jun 2002 16:32:20 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:36033 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S316994AbSFQUbO>; Mon, 17 Jun 2002 16:31:14 -0400
Date: Mon, 17 Jun 2002 13:31:15 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
In-Reply-To: <20020617160757.C1457@redhat.com>
Message-ID: <Pine.LNX.4.44.0206171326210.31265-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Benjamin LaHaise wrote:

> On Mon, Jun 17, 2002 at 01:03:15PM -0700, dean gaudet wrote:
> > 3x slower with the two cats in parallel.
>
> cat uses an incredibly small buffer for file io (4KB on x86), so
> running multiple cats in parallel will simply thrash your disk.
> What you really want is to run the open()s in parallel and the
> read()s sequentially (or in parallel with a large buffer to cut
> down on the seek cost).

using a 64KB buffer makes the xargs -P2 only twice as long as the -P1 ...
so that's an improvement, but still something seems odd.  (btw, many of
the files are tiny anyhow -- a bunch of maildirs mixed in amongst the
files.)

i'll try playing around with threading the open()s.

-dean

