Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289173AbSAMM4P>; Sun, 13 Jan 2002 07:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289174AbSAMMz6>; Sun, 13 Jan 2002 07:55:58 -0500
Received: from colorfullife.com ([216.156.138.34]:3590 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S289172AbSAMMzi>;
	Sun, 13 Jan 2002 07:55:38 -0500
Message-ID: <3C4183C5.8CF17487@colorfullife.com>
Date: Sun, 13 Jan 2002 13:55:33 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <Pine.LNX.4.33.0201131216230.24442-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:
> 
> 
> Yep, that'd be fine.  However, you then lose the neatness
> of "lock==file descriptor", and need something other than
> read/write for down/up.
> 
pread(), use the file pointer.

> 
> I guess the alternative is to store them in a hash table
> or tree but I don't know what that would do to the
> contended case.
>
I'd start with file descriptor+pread(), and then check how much faster
your could get without any protection at all (i.e. just trust user
space). If the difference is small, then use the file descriptor.

--
	Manfred
