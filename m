Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287641AbSAHEIQ>; Mon, 7 Jan 2002 23:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287639AbSAHEIH>; Mon, 7 Jan 2002 23:08:07 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:33550 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287631AbSAHEHw>;
	Mon, 7 Jan 2002 23:07:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Juan Quintela <quintela@mandrakesoft.com>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Tue, 8 Jan 2002 05:10:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NbYF-0001Qq-00@starship.berlin> <m2vgedq3v8.fsf@neno.dmz>
In-Reply-To: <m2vgedq3v8.fsf@neno.dmz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NnbM-0003DG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 09:54 pm, Juan Quintela wrote:
> >>>>> "daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> Hi
> 
> daniel> Minor nit:
> 
> daniel> if (!inode->u.ext2_ip)
> daniel> BUG();
> 
> daniel> You don't have to do this, if the pointer is null you will get a perfectly 
daniel> fine oops.
> 
> Without nice line information :(
> 
> Later, Juan.

Well that's a problem with the oopser, don't you think?  It's not right to put in
cpu-eating BUG checks for null pointer dereference all over the place just to work
around this deficiency.

--
Daniel
