Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUI2PlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUI2PlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUI2PlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:41:17 -0400
Received: from zero.aec.at ([193.170.194.10]:36877 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268580AbUI2PlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:41:12 -0400
To: Timur Tabi <timur.tabi@ammasso.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: get_user_pages() still broken in 2.6
References: <2JyXo-77W-19@gated-at.bofh.it> <2JzgH-7rT-11@gated-at.bofh.it>
	<2JOpu-1y1-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 29 Sep 2004 17:41:09 +0200
In-Reply-To: <2JOpu-1y1-21@gated-at.bofh.it> (Timur Tabi's message of "Wed,
 29 Sep 2004 17:20:14 +0200")
Message-ID: <m3acv93wx6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> writes:

> Christoph Hellwig wrote:
>
>> get_user_pages locks the page in memory.  It doesn't do anything about ptes.
>
> I don't understand the difference.  I thought a locked page is one
> that stays in memory (i.e. isn't swapped out) and whose physical
> address never changes.  Is that wrong?  All I need to do is keep a
> page in memory at the same physical address until I'm done with it.

After get_user_pages you don't need the page tables anymore. 
The struct page *s returned by it can be used for DMA.

-Andi

