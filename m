Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVDZAJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDZAJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDZAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:09:07 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:61005 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261182AbVDZAI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:08:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6DFA.4090908@ammasso.com> <20050425153542.70197e6a.akpm@osdl.org>
	<426D725C.4070103@ammasso.com> <20050425161330.32c32b4b.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 17:08:57 -0700
In-Reply-To: <20050425161330.32c32b4b.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 25 Apr 2005 16:13:30 -0700")
Message-ID: <52is2atn52.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 00:08:58.0220 (UTC) FILETIME=[24719AC0:01C549F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timur> If you look at the Infiniband code that was recently
    Timur> submitted, I think you'll see it does exactly that: after
    Timur> calling mlock(), the driver calls get_user_pages(), and it
    Timur> stores the page mappings for future use.

    Andrew> Where?

The code isn't merged yet.  I sent a version to lkml for review -- in
fact it was this very thread that we're in now.  The code in question
is in http://lkml.org/lkml/2005/4/4/266

This implements a "userspace verbs" character device that memory
registration goes through.  This means the kernel has a device node
that will be closed when a process dies, and so the memory can be
cleaned up.

 - R.
