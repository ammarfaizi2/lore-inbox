Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWGEAZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWGEAZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWGEAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:25:52 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32227 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932361AbWGEAZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:25:51 -0400
Date: Wed, 5 Jul 2006 09:17:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: clameter@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hugh@veritas.com, kernel@kolivas.org, marcelo@kvack.org, ak@suse.de
Subject: Re: [RFC 3/8] Move HIGHMEM counter into highmem.c/.h
Message-Id: <20060705091752.37c1a582.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <44AA9C58.2010707@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
	<20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com>
	<20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0607032253040.10856@schroedinger.engr.sgi.com>
	<20060703232020.260446d9.akpm@osdl.org>
	<Pine.LNX.4.64.0607040819230.13534@schroedinger.engr.sgi.com>
	<44AA9C58.2010707@yahoo.com.au>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2006 02:50:32 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Christoph Lameter wrote:
> > On Mon, 3 Jul 2006, Andrew Morton wrote:
> > 
> > 
> >>>Ok. Will put a #ifdef CONFIG_HIGHMEM around that statement and the 
> >>>following one.
> >>
> >>That will take the patchset up to 27 new ifdefs.  Is there a way of improving
> >>that?
> > 
> > 
> > Ideas are welcome. I can put some of the tests for zones together into one
> > big #ifdef in mmzone.h but otherwise this is going to be difficult.
> 
> I don't think there's much point. They all look pretty straightforward,
> and if you try doing something fancy it might just make it more fragile
> or harder to read.
> 
just one point.
I'm not sure dropping "printing HIGHMEM statistics" stuff is good or not.
It is shown in /proc/meminfo even if CONFIG_HIGHMEM=n now. this will change look
of user interface a bit. but maybe not so important ....

-Kame

