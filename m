Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312971AbSDKVMu>; Thu, 11 Apr 2002 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSDKVMt>; Thu, 11 Apr 2002 17:12:49 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:5387 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312971AbSDKVMt>; Thu, 11 Apr 2002 17:12:49 -0400
Message-ID: <3CB5EDC8.F817E382@zip.com.au>
Date: Thu, 11 Apr 2002 13:10:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Frank Krauss <fmfkrauss@mindspring.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Re: Possible EXT2 File System Corruption in Kernel 2.4
In-Reply-To: <E16vKwg-00056q-00@barry.mail.mindspring.net> <02041112492500.01786@sevencardstud.cable.nu> <20020411191255.GK3509@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> ...
>  EXT2 FILE SYSTEM
> -P:     Remy Card
> -M:     Remy.Card@linux.org
> -L:     linux-kernel@vger.kernel.org
> +L:     ext2-devel@lists.sourceforge.net
>  S:     Maintained

Yes, I'd support that.   It's a sad thing to do, but there
is no point in misleading people in this way.  Remy already
has an entry in ./CREDITS for ext2.

> This is unfortunately only a symptom of a problem and not the original
> cause.  There should have previously been errors saying "error - freeing
> blocks in system zone".  There is a patch I posted a few months ago to
> fix this symptom, but not the actual cause.

Do you have time to dust that patch off?  Shit happens, and the
filesystems should be robust in the presence of software and
hardware failures.  In this case the filesystem has reached
a point where it *knows* that it is about to do the wrong
thing, it emits a warning and then it just goes ahead and does it!

-
