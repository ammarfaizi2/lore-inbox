Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUJYIaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUJYIaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUJYI3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:29:37 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:32452 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261706AbUJYI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:29:16 -0400
Date: Mon, 25 Oct 2004 01:29:10 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Timo Sirainen <tss@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Message-ID: <20041025082910.GA17089@taniwha.stupidest.org>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 04:21:57AM +0300, Timo Sirainen wrote:

> My problem is that mails in a large maildir get temporarily
> lost. This happens because readdir() never returns a file which was
> just rename()d by another process. Either new or the old name would
> have been fine, but it's not returned at all.

i don't think there are well defined semantics for this, it's
intrinsically hard to make it work the way you want for a number of
reasons (and what they are depends on the underlying fs)

> Is there a chance this could get fixed? Every OS/filesystem I've
> tested so far has had the same problem

i'll argue it's an application bug

> so I'll have to implement some extra locking anyway (so much for
> maildir being lockless), but it would be nice to have at least one
> OS where it works without the extra locking overhead.

why do you need extra locking?  the next time the maildir is scanned
the message(s) will appear surely?


