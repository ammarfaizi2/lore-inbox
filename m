Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSI0Uqf>; Fri, 27 Sep 2002 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbSI0Uqf>; Fri, 27 Sep 2002 16:46:35 -0400
Received: from pD9E239ED.dip.t-dialin.net ([217.226.57.237]:61570 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261399AbSI0Uqf>; Fri, 27 Sep 2002 16:46:35 -0400
Date: Fri, 27 Sep 2002 14:52:38 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zach Brown <zab@zabbo.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <20020927163922.A13817@bitchcake.off.net>
Message-ID: <Pine.LNX.4.44.0209271450580.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 27 Sep 2002, Zach Brown wrote:
> > That's adding to front. One should be aware of that. The other add is
> > 
> > #define slist_add(_new_in, _head_in)            \
> > do {                                            \
> >         typeof(_head_in) _head = (_head_in),    \
> >                     _new = (_new_in);           \
> >         _new->next = _head->next;               \
> >         _head->next = _new;                     \
> > } while (0)
> 
> which is a degenerate case of slist_add_pos(), which is more
> complication than this trivial implementation needs.  have you looked at
> other single linked list implementations?  like glib's?  do you really
> think we need that in the kernel?

Where is this complicated? I don't even have one more line than the other. 
There are two positions relative to the head where we can put the list 
members, one of which is before, the other is after.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

