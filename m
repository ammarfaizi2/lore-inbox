Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbRAKM7F>; Thu, 11 Jan 2001 07:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131815AbRAKM6z>; Thu, 11 Jan 2001 07:58:55 -0500
Received: from zeus.kernel.org ([209.10.41.242]:33984 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131546AbRAKM6o>;
	Thu, 11 Jan 2001 07:58:44 -0500
Date: Thu, 11 Jan 2001 12:56:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Subtle MM bug
Message-ID: <20010111125604.A17177@redhat.com>
In-Reply-To: <E14GQyR-0000mh-00@the-village.bc.nu> <Pine.LNX.4.10.10101101210080.4572-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101101210080.4572-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 10, 2001 at 12:11:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 10, 2001 at 12:11:16PM -0800, Linus Torvalds wrote:
> 
> That said, we can easily support the notion of CLONE_CRED if we absolutely
> have to (and sane people just shouldn't use it), so if somebody wants to
> work on this for 2.5.x...

But is it really worth the pain?  I'd hate to have to audit the entire
VFS to make sure that it works if another thread changes our
credentials in the middle of a syscall, so we either end up having to
lock the credentials over every VFS syscall, or take a copy of the
credentials and pass it through every VFS internal call that we make.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
