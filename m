Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTIHDcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 23:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTIHDcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 23:32:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23884 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261918AbTIHDcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 23:32:46 -0400
Date: Sun, 7 Sep 2003 23:32:31 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <20030907130017.GA19977@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309072331220.10791-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Sep 2003, Jamie Lokier wrote:

> Hugh's patch is clever and subtle.  It doesn't exit the loop; the loop
> continues from "next".

ugh. It would be much cleaner to simply do a list_add() instead of a
list_add_tail(). (the ordering of the queue doesnt matter anyway)

	Ingo

