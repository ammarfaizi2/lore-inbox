Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbREVQHE>; Tue, 22 May 2001 12:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbREVQGy>; Tue, 22 May 2001 12:06:54 -0400
Received: from waste.org ([209.173.204.2]:35697 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262017AbREVQGt>;
	Tue, 22 May 2001 12:06:49 -0400
Date: Tue, 22 May 2001 11:08:16 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct char_device
In-Reply-To: <5.1.0.14.2.20010522153915.00ac1630@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0105221104070.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Anton Altaparmakov wrote:

> Hello,
>
> At 15:18 22/05/01, Alexander Viro wrote:
> [snip cool stuff]
> >+struct char_device {
> >+       struct list_head        hash;
> >+       atomic_t                count;
> >+       dev_t                   dev;
> >+       atomic_t                openers;
> >+       struct semaphore        sem;
>
> Why not name consistently with the struct block_device?
> I.e.:
> struct char_device {
>          struct list_head        cd_hash;
>          atomic_t                cd_count;
>          dev_t                   cd_dev;
>          atomic_t                cd_openers;
>          struct semaphore        cd_sem;
> };

Because foo_ is a throwback to the days when C compilers had a single
namespace for all structure elements, not a readability aid. If you need
foo_ to know what type of structure you're futzing with, you need to name
your variables better.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

