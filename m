Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262978AbSJGKvO>; Mon, 7 Oct 2002 06:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262979AbSJGKvO>; Mon, 7 Oct 2002 06:51:14 -0400
Received: from zero.aec.at ([193.170.194.10]:29458 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262978AbSJGKvN>;
	Mon, 7 Oct 2002 06:51:13 -0400
Date: Mon, 7 Oct 2002 12:56:22 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: rth@twiddle.net, jakub@redhat.com, ak@muc.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20021007105622.GA24530@averell>
References: <20020929152731.GA10631@averell> <20020929160113.K5659@devserv.devel.redhat.com> <20021007030541.A3910@twiddle.net> <20021007.032900.51704978.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007.032900.51704978.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:29:00PM +0200, David S. Miller wrote:
>    From: Richard Henderson <rth@twiddle.net>
>    Date: Mon, 7 Oct 2002 03:05:41 -0700
> 
>    On Sun, Sep 29, 2002 at 04:01:13PM -0400, Jakub Jelinek wrote:
>    > Does this matter when the kernel is compiled with -fno-strict-aliasing?
>    
>    Yes.  The malloc attribute uses REG_NOALIAS, not alias sets.
>    
> Great, I'm all for Andi's patch in that case.

I retested it on gcc 3.2 and it unfortunately doesn't make any difference
(resulting kernel is byte-for-byte identical). So it looks like with
current gcc it isn't worth the effort.

-Andi
