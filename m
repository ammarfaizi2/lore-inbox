Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbRECTsG>; Thu, 3 May 2001 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133071AbRECTr4>; Thu, 3 May 2001 15:47:56 -0400
Received: from SLASH.REM.CMU.EDU ([128.2.87.44]:41736 "EHLO SLASH.REM.CMU.EDU")
	by vger.kernel.org with ESMTP id <S132993AbRECTrr>;
	Thu, 3 May 2001 15:47:47 -0400
From: agrawal@ais.org
Date: Thu, 3 May 2001 15:50:07 -0400 (EDT)
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010503210904.B9715@bug.ucw.cz>
Message-ID: <Pine.LNX.4.10.10105031541190.32369-100000@SLASH.REM.CMU.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001, Pavel Machek wrote:

> That means that for fooling closed-source statically-linked binary,
> you now need to patch kernel. That's regression; subterfugue.org could
> do this with normal user rights in 2.4.0.

This is particularly pretty, but something that might work:

1. a "deceiver" process creates a shared memory page, populates shared
   page with appropriate magic (perhaps copying from its own magic page?)
2. have subterfuge unmap the magic page for the fooled process, and map in
   the shared page in its place (assumes subterfuge can insert system
   calls, instead of just modifying them)
3. deceiver periodically updates magic page



