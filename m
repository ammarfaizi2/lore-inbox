Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSIZSjg>; Thu, 26 Sep 2002 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSIZSjg>; Thu, 26 Sep 2002 14:39:36 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:13032 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261436AbSIZSjg>; Thu, 26 Sep 2002 14:39:36 -0400
Date: Thu, 26 Sep 2002 12:45:35 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <20020926142547.N13817@bitchcake.off.net>
Message-ID: <Pine.LNX.4.44.0209261244560.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My point is:

We don't know the parent structure. We shouldn't know it, since it takes
time. So I try to keep the address pointer stable instead of just
exchanging pointers.

That's why I'm exchanging pointers, and that's also why slist_del()
currently returns a value: because the deleted list entry would otherwise
be lost in space...

If any applicator needs to know a list header (primer), he shall produce
one and pass the first entry after the primer. We should only depend on
one single facility: the next field of the handled structure.

Also notice that we can restart list_for_each*() from any position.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

