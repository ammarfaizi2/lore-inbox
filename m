Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSEVE6k>; Wed, 22 May 2002 00:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSEVE6j>; Wed, 22 May 2002 00:58:39 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:33717 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316856AbSEVE6j>; Wed, 22 May 2002 00:58:39 -0400
Date: Wed, 22 May 2002 14:57:46 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-Id: <20020522145746.69756cf5.rusty@rustcorp.com.au>
In-Reply-To: <E17AHQw-0000Jq-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002 22:44:42 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > So if you pass bad pointer to read(), why would you expect "number of
> > bytes read" return? Its true that kernel can't simply not return
> 
> Because the standard says either you return the errorcode and no data
> is transferred or for a partial I/O you return how much was done.

Hmm... I can't find anything like that in SuSv2: can you give a reference?

And we're already violating that for the write() case.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
