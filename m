Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUFSWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUFSWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUFSWE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:04:58 -0400
Received: from zero.aec.at ([193.170.194.10]:21766 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261685AbUFSWE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:04:56 -0400
To: "David S. Miller" <davem@redhat.com>
cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: mincore on anon mappings
References: <28R2T-8ld-13@gated-at.bofh.it> <28Tev-1Bm-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 20 Jun 2004 02:05:19 +0200
In-Reply-To: <28Tev-1Bm-23@gated-at.bofh.it> (David S. Miller's message of
 "Sat, 19 Jun 2004 21:00:15 +0200")
Message-ID: <m33c4rrt4w.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>
> Therefore I propose we add a MAP_FORCE which does exactly what GCC wants
> which is:
>
> 1) The passed in 'hint' address is treated as mandatory, if exactly that
>    address cannot be used, we fail.
>
> 2) Existing areas get in the way, and cause failure.

That sounds unintuitive. I would expect MAP_FORCE to do exactly
that (that is is done by default right now is a different story).
But you want to reverse the meaning.

How about calling it MAP_STRICT or just MAP_CHECK ? 

>
> 3) get_unmapped_area() implementations shut off any 'hint' address
>    modification logic they may have.

Good idea definitely.


-Andi

