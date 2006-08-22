Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWHVLGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWHVLGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHVLGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:06:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49379 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932167AbWHVLGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:06:38 -0400
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2006 13:06:34 +0200
In-Reply-To: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <p73bqqd81xh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> listtoken , a helper for walking a list by intermittent access.
> 
> When we walk a list intermittently and the list is being modified at the
> same time, it's hard to remember our position in it.
> 
> With this list token, a user can remember where he is reading by inserting
> a token in the list.

I think the header/code needs much more comments so that other people
can still make sense of it later. Even with the commit log it's not
quite clear how it works.

Also locking needs to be explained. I suppose only one user is allowed
to use a token at one time?

But overall it's a good idea to have a generic facility like this.
I suppose it will be a more common problem in the future.

-Andi
