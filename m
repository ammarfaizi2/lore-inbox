Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUAGJ4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUAGJyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:54:33 -0500
Received: from nat-pool-sfbay.redhat.com ([66.187.237.200]:24845 "EHLO
	frothingslosh.sfbay.redhat.com") by vger.kernel.org with ESMTP
	id S266164AbUAGJy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:54:27 -0500
Date: Wed, 7 Jan 2004 01:54:22 -0800
From: Richard Henderson <rth@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Mosberger-Tang <David.Mosberger@acm.org>, davidm@mostang.com,
       linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
Message-ID: <20040107095422.GA21007@redhat.com>
References: <16PqK-8eK-1@gated-at.bofh.it> <16RiU-2kO-1@gated-at.bofh.it> <16S5h-3no-5@gated-at.bofh.it> <ug3casyegk.fsf@panda.mostang.com> <20040106223302.GB18646@redhat.com> <Pine.LNX.4.58.0401061515370.9166@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401061515370.9166@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 03:23:31PM -0800, Linus Torvalds wrote:
> > In ANSI C you've no alternative except memcpy, since you can't cast
> > the pointer and reference the object via some other type (assuming
> > neither type is char, yadda yadda).
> 
> Sure you have. You can _always_ change
> 
> 	(a ? b : c) = d;
> 
> to
> 
> 	tmp = d;
> 	a ? (b = tmp) : (c = tmp);

No, I meant his bitfield macro at all.  You can't just go and 
construct a bit field at random and dereference it.


r~
