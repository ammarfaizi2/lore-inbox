Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTIHJ6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbTIHJ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:58:07 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12393 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262239AbTIHJ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:58:04 -0400
Date: Mon, 8 Sep 2003 05:57:54 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <20030908093322.GA25176@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309080555060.17897-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Jamie Lokier wrote:

> Why do you say the order doesn't matter?  If you change the order in
> FUTEX_WAIT & FUTEX_WAKE, then "fair" operations aren't fair any more.

hm, indeed, the ordering of wake-one/wake-few wakeups would be impacted.

> Is there a reason why FUTEX_REQUEUE is exempt from this?

no, you are right - FIFO queueing must be preserved there too.

	Ingo

