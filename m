Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280236AbRKEFbM>; Mon, 5 Nov 2001 00:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280238AbRKEFbC>; Mon, 5 Nov 2001 00:31:02 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:25102 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280236AbRKEFav>;
	Mon, 5 Nov 2001 00:30:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Jeff Dike <jdike@karaya.com>
Subject: Re: Special Kernel Modification
Date: Sun, 4 Nov 2001 21:30:38 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111050552.AAA06451@ccure.karaya.com>
In-Reply-To: <200111050552.AAA06451@ccure.karaya.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E160cLH-0001Nw-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 21:52, you wrote:
> bodnar42@phalynx.dhs.org said:
> > >  Mounting it synchronous will  disable caching in the VM.
> >
> > Who told
> > you that? Synchronous mounting turns off write buffering. Even with
> > "-o sync" writes will still end up in the page cache, they'll just be
> > commited immediately.
>
> Ummm, how about O_DIRECT instead of O_SYNC (or maybe as well, my googling
> hasn't been clear on whether O_DIRECT bypasses the cache on writes as
> well)?
>

Nope, last I checked O_DIRECT enforces buffer and file offset alignment. 
Normal apps wouldn't work very well at all. Maybe UML needs some hacks around 
the whole caching issue?

-Ryan
