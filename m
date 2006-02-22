Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWBVHnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBVHnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWBVHnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:43:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932245AbWBVHnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:43:09 -0500
Date: Tue, 21 Feb 2006 23:41:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, ak@suse.de, holt@sgi.com, bcasavan@sgi.com, cr@sap.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: fix mount mpol nodelist parsing
Message-Id: <20060221234104.7cf4e84c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602220658390.6196@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
	<20060221183004.72ffa011.akpm@osdl.org>
	<Pine.LNX.4.61.0602220658390.6196@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> But perhaps I should expand the mention of CONFIG_NUMA in tmpfs.txt,
>  to explain the issue, and suggest that "mpol=" be used in remounts
>  rather than automatic mounts on systems where it might be a problem.
>  I'll dream up some wording later.

Yes, a remount is the way this feature should be used.

>  > [ Vaguely suprised that tmpfs isn't using match_token()... ]
> 
>  I did briefly consider that back in the days when I noticed a host of
>  fs filesystems got converted.  But didn't see any point in messing
>  with what was already working.  Haven't looked recently: would it
>  actually be a useful change to make?

I guess it'd be nice to do for uniformity's sake, but it's hardly pressing.
I have a vague memory that the ext3 conversion actually increased .text
size, which was a bit irritating.

