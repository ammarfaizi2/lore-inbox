Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFTMNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTFTMNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 08:13:44 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:19448 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263025AbTFTMNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 08:13:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Neil Moore <neil@s-z.org>, linux-kernel@vger.kernel.org
Subject: Re: Unix code in Linux
Date: Fri, 20 Jun 2003 07:27:02 -0500
X-Mailer: KMail [version 1.2]
References: <E19T87m-000367-SF@dirac.s-z.org>
In-Reply-To: <E19T87m-000367-SF@dirac.s-z.org>
MIME-Version: 1.0
Message-Id: <03062007270201.27242@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 June 2003 17:43, Neil Moore wrote:
> Slashdotter lspd pointed this out in a recent thread, thereby
> demonstrating that slashdot isn't completely useless.
>
> Compare:
>   /usr/src/linux/arch/ia64/sn/io/ate_utils.c in Linux
> to:
>   unix/malloc.c in UNIX 6th Edition (page 25 of the Lions code,
>   lines 2522--2589)
>
> atefree() is very obviously based on Unix's mfree(), and atealloc() on
> malloc().  atefree()/mfree() even have the *same leading comment*.  Of
> course, there are some changes, but the overall structure and many of
> the details remain.
>
> The copyright notice on ate_utils.c says:
>
>  * This file is subject to the terms and conditions of the GNU General
> Public * License.  See the file "COPYING" in the main directory of this
> archive * for more details.
>  *
>  * Copyright (C) 1992 - 1997, 2000-2002 Silicon Graphics, Inc. All rights
> reserved.
>
>
> This code is obviously not a trade secret, since it has been published
> in the 1996 version of the Lions book.  However, it is copyrighted,
> and the book's (C) notice says:
>   . . . SCO [i.e. the Santa Cruz Operation, not The SCO Group] has
>   granted a license to publish solely for the purpose of creating an
>   educational work.  SCO grants no license for any other use of this
>   material . . . .

I believe the original malloc/free code came from the "C programming language"
way back around 1975-79".

Almost all of the base allocators came out of that book. And it was listed
only as "a memory allocator", and the algorithms go back even farther. (I was
taught that one using a fortran array around 1973.. and was told then that
it had been used by IBM/CDC/... for memory allocation in assembler...)

Really.. there are only so many different ways to allocate memory, and this is
one of the most basic. Lisp interpreters always had the most elaborate and
complete ones, including this one. It is only slightly more complex than the
old stack "mark/release" allocator in Pascal.
