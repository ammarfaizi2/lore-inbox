Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTIHJeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTIHJe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:34:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21391 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262177AbTIHJdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:33:47 -0400
Date: Mon, 8 Sep 2003 10:33:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030908093322.GA25176@mail.jlokier.co.uk>
References: <20030907130017.GA19977@mail.jlokier.co.uk> <Pine.LNX.4.44.0309072331220.10791-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309072331220.10791-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > Hugh's patch is clever and subtle.  It doesn't exit the loop; the loop
> > continues from "next".
> 
> ugh. It would be much cleaner to simply do a list_add() instead of a
> list_add_tail(). (the ordering of the queue doesnt matter anyway)

Why do you say the order doesn't matter?  If you change the order in
FUTEX_WAIT & FUTEX_WAKE, then "fair" operations aren't fair any more.

Is there a reason why FUTEX_REQUEUE is exempt from this?

-- Jamie

