Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130970AbRAYXUZ>; Thu, 25 Jan 2001 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRAYXUT>; Thu, 25 Jan 2001 18:20:19 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59657 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130970AbRAYXUD>; Thu, 25 Jan 2001 18:20:03 -0500
Date: Thu, 25 Jan 2001 19:30:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@innominate.de>
cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: inode->i_dirty_buffers redundant ?
In-Reply-To: <3A708722.C21EC12A@innominate.de>
Message-ID: <Pine.LNX.4.21.0101251925190.11559-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jan 2001, Daniel Phillips wrote:

> "Stephen C. Tweedie" wrote:
> > We also maintain the 
> > per-page buffer lists as caches of the virtual-to-physical mapping to
> > avoid redundant bmap()ping.
> 
> Could you clarify that one, please?

Daniel, 

With "physical mapping" Stephen means on-disk block number.

If the buffer(s) for a page are mapped with valid information (ie
BH_Mapped) we avoid calling get_block(). 

See?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
