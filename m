Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUFSO0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUFSO0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUFSO0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:26:06 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58314 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261914AbUFSO0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:26:03 -0400
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
From: Albert Cahalan <albert@users.sf.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de,
       bcasavan@sgi.com
In-Reply-To: <E1BbXoj-0006t2-00@gondolin.me.apana.org.au>
References: <E1BbXoj-0006t2-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Organization: 
Message-Id: <1087646624.8188.852.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Jun 2004 08:03:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 00:51, Herbert Xu wrote:
> Albert Cahalan <albert@users.sf.net> wrote:
> >
> >> Are you saying your top reads /proc/kallsyms on each redisplay? 
> >> That sounds completely wrong - it should only read the file once
> >> and cache it and then look the numbers it is reading from wchan
> >> in the cache.
> >>
> >> Doing the cache in the kernel is the wrong place. This should be fixed
> >> in user space.
> > 
> > No way, because:
> > 
> > 1. kernel modules may be loaded or unloaded at any time
> 
> We seem to have coped alright under 2.4.

Not really. We coped alright long ago. Things were
getting worse year by year, with modules becoming
more popular and their symbols not 100% exported.


