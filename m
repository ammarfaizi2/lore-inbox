Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbTEFHIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTEFHIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:08:21 -0400
Received: from [12.47.58.20] ([12.47.58.20]:60435 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262412AbTEFHIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:08:18 -0400
Date: Tue, 6 May 2003 00:22:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030506002229.631a642a.akpm@digeo.com>
In-Reply-To: <20030505.225748.35026531.davem@redhat.com>
References: <20030505224815.07e5240c.akpm@digeo.com>
	<20030505.223554.88485673.davem@redhat.com>
	<20030505235549.5df75866.akpm@digeo.com>
	<20030505.225748.35026531.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 07:20:43.0431 (UTC) FILETIME=[01515B70:01C313A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> Make kmalloc_per_cpu() merely a convenience macro, made up of existing
> non-percpu primitives.

I think we're agreeing here.

The current kmalloc_percpu() is a wrapper around kmalloc.  That seems OK to
me.

What we _do_ want to solve is the problem that DEFINE_PERCPU() does not work
in modules.  Rusty's patch (reworked to not alter kmalloc_percpu) would suit
that requirement.


(kiran has a new version of kmalloc_percpu() which may be faster than the
current one, but for the purposes of this discussion it's equivalent).

