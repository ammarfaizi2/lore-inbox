Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUDUVob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUDUVob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUDUVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:44:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:4230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbUDUVoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:44:30 -0400
Date: Wed, 21 Apr 2004 14:46:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: torvalds@osdl.org, andrea@suse.de, agruen@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
Message-Id: <20040421144647.7a0a82e6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404211910510.11762-100000@dbl.q-ag.de>
References: <Pine.LNX.4.58.0404201146560.1775@ppc970.osdl.org>
	<Pine.LNX.4.44.0404211910510.11762-100000@dbl.q-ag.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> There is one additional point: right now slab uses ints for the bufctls.
> Using short would save two bytes for each object. Initially I had used
> short, but davem objected. IIRC because some archs do not handle short
> effeciently. Should I allow arch overrides for the bufctls? On i386,
> saving two bytes might allow a few additional anon_vma objects in each
> page.

There's one bufctl per object, yes?

Sounds like a worthwhile optimisation.
