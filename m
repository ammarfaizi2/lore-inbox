Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751906AbWB1Gm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWB1Gm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWB1Gm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:42:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751906AbWB1GmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:42:25 -0500
Date: Tue, 28 Feb 2006 01:41:40 -0500
From: Dave Jones <davej@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060228064140.GE28434@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, perex@suse.cz,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de> <20060228063207.GA12502@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228063207.GA12502@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 01:32:07AM -0500, Theodore Ts'o wrote:

 > Another alternative, as a few people including myself have noted, is to
 > shipping that part of the userspace with the kernel sources, so that
 > it is part of the kernel sources from a release management point of
 > view, even if it lives in userspace.  

For system-critical bits of userspace I think this makes a lot
of sense for another reason: Code review.   Userspace code doesn't
get anywhere near the scrutiny that kernel code gets.

We still allow the occasional crap into the kernel that probably
could have used another trip around the block before merging, but
the barrier to entry for new code is a lot higher than it used
to be a few years ago.

Moving stuff out to userspace is a 'get out of jail' card for a lot
of authors, but if we're all going to be relying on that code
doing the right thing, it should get an equal amount of code review.

		Dave

