Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292239AbSBUA1r>; Wed, 20 Feb 2002 19:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292265AbSBUA1h>; Wed, 20 Feb 2002 19:27:37 -0500
Received: from zok.sgi.com ([204.94.215.101]:25555 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292239AbSBUA13>;
	Wed, 20 Feb 2002 19:27:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christer Weinigel <wingel@nano-system.com>
Cc: roy@karlsbakk.net, linux-kernel@vger.kernel.org
Subject: Re: SC1200 support? 
In-Reply-To: Your message of "Thu, 21 Feb 2002 01:02:02 BST."
             <20020221000202.363E6F5B@acolyte.hack.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Feb 2002 11:27:06 +1100
Message-ID: <6985.1014251226@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 01:02:02 +0100 (CET), 
Christer Weinigel <wingel@nano-system.com> wrote:
>Darn, I've been meaning to clean these patches up for a month or so,
>but I haven't had the time yet.  I've made a snapshot of my CVS tree
>that you can find at:
>
>    http://www.nano-system.com/scx200/
>
>First of all, the current snapshot is based upon Linux-2.4.17 + Keith
>Owens kbuild-2.5 system...
>It should be trivial to move these drivers to a newer Linux kernel and
>to work without the kbuild stuff.

I assume that the nano files are in a shadow tree.  You can convert
base plus shadow trees to a single view by

  make -f $KBUILD_SRCTREE_000/Makefile-2.5 $KBUILD_OBJTREE/.tmp_src

$KBUILD_OBJTREE/.tmp_src will be built as a directory containing 10,000
symlinks pointing at the relevant source files.
  
  diff -urN $KBUILD_SRCTREE_000 $KBUILD_OBJTREE/.tmp_src

to generate a patch from base to base+shadow.  Use that diff against a
separate copy of the base tree as a starting point for kbuild 2.4.


