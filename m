Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131283AbRBLPxd>; Mon, 12 Feb 2001 10:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRBLPxX>; Mon, 12 Feb 2001 10:53:23 -0500
Received: from zeus.kernel.org ([209.10.41.242]:24524 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131283AbRBLPxP>;
	Mon, 12 Feb 2001 10:53:15 -0500
Date: Mon, 12 Feb 2001 15:50:14 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Brian Grossman <brian@SoftHome.net>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: ext2: block > big ?
Message-ID: <20010212155014.A32551@redhat.com>
In-Reply-To: <20010212004402.3433.qmail@lindy.softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212004402.3433.qmail@lindy.softhome.net>; from brian@SoftHome.net on Sun, Feb 11, 2001 at 05:44:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 11, 2001 at 05:44:02PM -0700, Brian Grossman wrote:
> 
> What does a message like 'ext2: block > big' indicate?

An attempt was made to access a block beyond the legal max size for an
ext2 file.  That probably implies a corrupt inode, because the ext2
file write code checks for that limit and won't attempt to write
beyond the boundary.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
