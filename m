Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWHVLUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWHVLUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHVLUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:20:49 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:13794 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932174AbWHVLUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:20:48 -0400
Date: Tue, 22 Aug 2006 20:23:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
Message-Id: <20060822202350.35be06fc.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <p73bqqd81xh.fsf@verdi.suse.de>
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	<p73bqqd81xh.fsf@verdi.suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2006 13:06:34 +0200
Andi Kleen <ak@suse.de> wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> > 
> > listtoken , a helper for walking a list by intermittent access.
> > 
> > When we walk a list intermittently and the list is being modified at the
> > same time, it's hard to remember our position in it.
> > 
> > With this list token, a user can remember where he is reading by inserting
> > a token in the list.
> 
> I think the header/code needs much more comments so that other people
> can still make sense of it later. Even with the commit log it's not
> quite clear how it works.
> 
Okay, make them more informative.

> Also locking needs to be explained. 
Yes, with RCU. we need appropriate lock.

> I suppose only one user is allowed to use a token at one time?
> 
Yes, I expext that a user uses a token. But several tokens can be inserted to a list.

> But overall it's a good idea to have a generic facility like this.
> I suppose it will be a more common problem in the future.
> 

Thanks,
-Kame

