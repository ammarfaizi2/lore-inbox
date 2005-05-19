Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVESBGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVESBGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVESBGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:06:44 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:3025 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262438AbVESBGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:06:12 -0400
Message-ID: <49224.63.126.101.126.1116464767.squirrel@63.126.101.126>
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
References: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
Date: Wed, 18 May 2005 18:06:07 -0700 (PDT)
Subject: RE: Illegal use of reserved word in system.h
From: rdunlap@xenotime.net
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32625 32003] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: /usr/local/cpanel/3rdparty/bin/php
X-Source-Args: /usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/base/3rdparty/squirrelmail/src/compose.php 
X-Source-Dir: :/base/3rdparty/squirrelmail/src
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gilbert, John said:
> Hello all,
>

Hi,

FWIW, I agree with you.  I have a 'sparse' extension (that
Linus mostly wrote) that detects/warns on all C++ reserved words.

This could be part of a needed general headers cleanup,
although a fairly low priority part of it.

>
> Sorry about the automatic disclaimer at the bottom of these emails, it's
>
> part of working here at Dolby. I'm sure it doesn't apply to this
>
> discussion.
>
>
>
> I had a few responses to this bug fix request (which I did mail to this
>
> list), none were what I was hoping for, namely "This will be fixed in
>
> the next release", so allow me to clarify.
>
>
>
> The problem: Linux kernel headers use C++ reserved words as variable
>
> names. This breaks builds of C++ code that include kernel headers.
>
>
>
> Examples: The use of "new" in the macro __cmpxchg in system.h. This hits
>
> MySQL which links into the kernel headers to determine if the platform
>
> is SMP aware or not (don't ask me why.)
>
> 	The use of "virtual" in the structure drm_buf_map in drm.h, used
>
> by drm_bufs.c. This hits C++ code that uses the DRI interface to lock
>
> with vertical retrace.
>
>
>
> The solution: rename these variables, keep C++ reserved words out of
>
> headers, make this practice part of the style guide.
>
>
>
> I'm not advocating writing parts of the kernel in C++, or cleaning out
>
> reserved words in the entire kernel. I know the one and only true
>
> language is C, but for Linux to achieve world domination it needs to be
>
> inclusive at running (and building) any software in whatever language.
>
>
>
> As to the comments stating that "Userspace code shouldn't include kernel
>
> headers", that's fine in the "Hello, World", but in the real world,
>
> applications need access to devices and system resources, which means
>
> communicating with the kernel with the proper ioctls, flags, system
>
> configuration, data structures, etc., which are kept in kernel headers.
>
> For this reason, breaking these apart from the application build
>
> environment is a really bad idea, no mater what Linus Torvalds has to
>
> say about it (see
>
> http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html). It needs to
>
> be an fully integrated system for everything to run correctly.
>
>
>
> Besides, I don't have time to rewrite MySQL in C to make it "correct".
>
> I've got more important things to do. ;^)
>
>
>
> So please, keep your headers clean.
>
>
>
> John Gilbert
>
> jgg@dolby.com
>
>
>
> Ignore the sig.
>
> ###############
>
> -----------------------------------------
>
> This message (including any attachments) may contain confidential
>
> information intended for a specific individual and purpose.  If you are
> not
>
> the intended recipient, delete this message.  If you are not the intended
>
> recipient, disclosing, copying, distributing, or taking any action based
> on
>
> this message is strictly prohibited.



-- 
~Randy
