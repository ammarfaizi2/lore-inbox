Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRESTjt>; Sat, 19 May 2001 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262097AbRESTj1>; Sat, 19 May 2001 15:39:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3347 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262001AbRESTjW>; Sat, 19 May 2001 15:39:22 -0400
Date: Sat, 19 May 2001 12:39:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <20010515161750.B38@toy.ucw.cz>
Message-ID: <Pine.LNX.4.21.0105191238040.14472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Pavel Machek wrote:
> 
> resume from disk is actually pretty hard to do in way it is readed linearily.
> 
> While playing with swsusp patches (== suspend to disk) I found out that
> it was slow. It needs to do atomic snapshot, and only reasonable way to
> do that is free half of RAM, cli() and copy.

Note that "resume from disk" does _not_ have to necessarily resume kernel
data structures. It is enough if it just resumes the caches etc. 

Don't get _too_ hung up about the power-management kind of "invisible
suspend/resume" sequence where you resume the whole kernel state.

		Linus

