Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUAFWdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAFWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:33:31 -0500
Received: from nat-pool-sfbay.redhat.com ([66.187.237.200]:44849 "EHLO
	frothingslosh.sfbay.redhat.com") by vger.kernel.org with ESMTP
	id S265427AbUAFWdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:33:09 -0500
Date: Tue, 6 Jan 2004 14:33:02 -0800
From: Richard Henderson <rth@redhat.com>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: torvalds@osdl.org, davidm@mostang.com, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
Message-ID: <20040106223302.GB18646@redhat.com>
References: <16PqK-8eK-1@gated-at.bofh.it> <16RiU-2kO-1@gated-at.bofh.it> <16S5h-3no-5@gated-at.bofh.it> <ug3casyegk.fsf@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ug3casyegk.fsf@panda.mostang.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 01:06:19PM -0800, David Mosberger-Tang wrote:
> This works provided you can take the address of the lvalue, which
> ain't true for bitfields.

Indeed.  Which means that the compiler almost certainly would have
done the wrong thing in certain cases with the conditional lvalue
extension.

There were real, hard to fix bugs here.  Rather than sweat too much
about what the "right" semantics are supposed to be, and how to get
them all "correct", we just removed the ill-thought extension.

> I'd love to know a way of doing this in ANSI C99 without requiring
> changes to to uses of this kind of (atrocious) macro...

In ANSI C you've no alternative except memcpy, since you can't cast
the pointer and reference the object via some other type (assuming
neither type is char, yadda yadda).


r~
