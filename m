Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSFDWIo>; Tue, 4 Jun 2002 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSFDWIn>; Tue, 4 Jun 2002 18:08:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34826 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316860AbSFDWIj>; Tue, 4 Jun 2002 18:08:39 -0400
Date: Tue, 4 Jun 2002 15:08:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Craig Milo Rogers <rogers@ISI.EDU>
cc: Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink 
In-Reply-To: <8692.1023228303@ISI.EDU>
Message-ID: <Pine.LNX.4.44.0206041507450.891-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jun 2002, Craig Milo Rogers wrote:
>
> >Sure. However, I don't think it should come as any surprise to anybody
> >that trying to write to two different points in the same file is a bad
> >idea.
>
> 	Databases?

They uniformly (as far as I know) preallocate all the data blocks.

Exactly to avoid the block layout issue - they want the data blocks as
contiguous as possible.

		Linus

