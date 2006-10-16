Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWJPN2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWJPN2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWJPN2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:28:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:35464 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750708AbWJPN2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:28:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, gk@garethknight.com
Subject: Re: [PATCH] generic signal code (small new feature - userspace signal mask), kernel 2.6.16
References: <5B1B60D4-4259-4720-A5A5-9691CA59E250@garethknight.com>
	<Pine.LNX.4.64.0610152025300.3962@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 15:28:39 +0200
In-Reply-To: <Pine.LNX.4.64.0610152025300.3962@g5.osdl.org>
Message-ID: <p731wp8e6ew.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> Why? You're doing user-space accesses from within critical sections with a 
> spinlock, and that's just a big no-no. Think page faults, swapping etc.

He could pin the page in memory like futexes do. One page pinned
per thread shouldn't be a big DOS issue either.

-Andi
