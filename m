Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWHYIei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWHYIei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWHYIei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:34:38 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:23458 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932133AbWHYIei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:34:38 -0400
Date: Fri, 25 Aug 2006 10:33:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LogFS
Message-ID: <20060825083343.GA11136@wohnheim.fh-wedel.de>
References: <20060824134430.GB17132@wohnheim.fh-wedel.de> <p73wt8ydu1v.fsf@verdi.suse.de> <20060824155434.GA31877@wohnheim.fh-wedel.de> <20060824215111.dddcb330.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060824215111.dddcb330.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 August 2006 21:51:11 -0700, Andrew Morton wrote:
> On Thu, 24 Aug 2006 17:54:34 +0200
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> > Linux needs a decent flash filesystem.
> 
> Would http://nilfs.org/en/ be useful on flash?

I am having trouble answering that question, but feel inclined to
answer no.

They don't have a cleaner yet.  After my experience and looking at
their data structure, I wish them luck to succeed without a change to
the on-disk format.  Most likely they will be unable to prove
correctness and take the standard approach of keeping "some amount" of
space reserved and hoping for the best.

Btrees are an interesting idea.

Buffer heads are a fairly pointless thing when dealing with flash.

Plus my general feeling is that they care only about hard disks and
optimizations for disks and flash are quite different.  In the future,
it might make sense to have a generic log-structured filesystem that
works splendidly on both.  But I see merit in optimizing each on its
own until it is clear which details work for both and which don't.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
