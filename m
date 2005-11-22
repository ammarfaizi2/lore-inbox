Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVKVO5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVKVO5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVKVO5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:57:10 -0500
Received: from thunk.org ([69.25.196.29]:43757 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964953AbVKVO5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:57:09 -0500
Date: Tue, 22 Nov 2005 09:56:47 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun's ZFS and Linux
Message-ID: <20051122145647.GC29179@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com> <20051119172337.GA24765@thunk.org> <438230B6.8070503@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438230B6.8070503@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 03:40:22PM -0500, Bill Davidsen wrote:
> >That wouldn't be a "port", it would have to be a complete
> >reimplementation from scratch.  And, of course, of further concern
> >would be whether or not there are any patents that Sun may have filed
> >covering ZFS.  If the patents have only been licensed for CDDL
> >licensed code, then that won't help a GPL'ed covered reimplementation.
> >
> What a great chance to try out userfs.

Just for yucks, people who are interested in doing might want to first
implement ext2 in userspace --- this would be relatively easy, given
that most of the code to do this is already in libext2fs, and
interface it to userfs.  Next, benchmark ext2 in userspace using
userfs, and compare it to ext2 running in the kernel using the
identical kernel and hardware configuration, and report on the
results.  Try doing this on both a uniprocessor system as well as a
4-way SMP system, and let us know what you find.....  

I think I know, but it would be a very interesting experiment, and
would probably be a great paper to publish at some conference such as
OLS, LCA, LK, etc., especially if were combined with suggestions about
how to improve userfs's performance.

						- Ted
