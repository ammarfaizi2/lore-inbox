Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSEVFBW>; Wed, 22 May 2002 01:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316859AbSEVFBV>; Wed, 22 May 2002 01:01:21 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:21688 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316857AbSEVFBU>; Wed, 22 May 2002 01:01:20 -0400
Date: Wed, 22 May 2002 15:01:14 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: alan@lxorguk.ukuu.org.uk, pavel@suse.cz, linux-kernel@vger.kernel.org,
        paulus@samba.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-Id: <20020522150114.63a45f09.rusty@rustcorp.com.au>
In-Reply-To: <3CEAC020.4F63A181@zip.com.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002 14:46:08 -0700
Andrew Morton <akpm@zip.com.au> wrote:
> Pavel makes a reasonable point that copy_*_user may elect
> to copy the data in something other than strictly ascending
> user virtual addresses.  In which case it's not possible to return
> a sane "how much was copied" number.

If I understand Paulus correctly, PPC64 could share their optimized memcpy
routine (ie. icache win), from which it is really hard to tell how far we got
before we faulted.

You then do the fixup search on the link register (ie. to find the caller).

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
