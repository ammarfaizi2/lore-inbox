Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUHHSnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUHHSnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUHHSnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:43:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19620 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266137AbUHHSni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:43:38 -0400
Date: Sun, 8 Aug 2004 19:43:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Oskar Berggren <beo@sgs.o.se>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Bug in 2.6.8-rc3 at mm/page_alloc.c:792 and mm/rmap.c:407
In-Reply-To: <1091977911.7221.13.camel@pitr.ekb.sgsnet.se>
Message-ID: <Pine.LNX.4.44.0408081930050.2366-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Oskar Berggren wrote:
> Two BUG's I've been seeing, one in page_alloc.c and one in rmap.c.

This is not the first report of an rmap.c:407,
Denis reported one a week ago (on 2.6.7-bk20).

I don't know what's behind it, but I am wondering if PageReserved
might be getting cleared while page is still mapped into userspace.

You both have sound modules in, are you using audio?

Could you mail me (privately) your /var/log/messages, Oskar, I don't
have a clear picture of the relation between your page_alloc.c:792s,
your rmap.c:407s and your other oopses.

Thanks,
Hugh

