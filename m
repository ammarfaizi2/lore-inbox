Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313996AbSEFAmI>; Sun, 5 May 2002 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314025AbSEFAmI>; Sun, 5 May 2002 20:42:08 -0400
Received: from zok.SGI.COM ([204.94.215.101]:32462 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S313996AbSEFAmG>;
	Sun, 5 May 2002 20:42:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: dank@kegel.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sun, 05 May 2002 17:02:30 MST."
             <3CD5C816.D73F0532@kegel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 10:40:22 +1000
Message-ID: <9358.1020645622@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2002 17:02:30 -0700, 
Dan Kegel <dank@kegel.com> wrote:
>BTW I'm looking at your kbuild 2.5 performance measurements at
>http://www.mail-archive.com/kbuild-devel%40lists.sourceforge.net/msg01434.html
>Looks like 9 seconds to rebuild the kernel after a small change
>on a quad 700MHz pentium, right?   (Or does 'make phase4' not actually build?)

Those times are for the full timestamp, dependency and integrity
checking.  phase4 does not build.  Actual kernel build time depends on
what has changed, what needs to be rebuilt and whether you are
compressing the kernel.

>What would the time be on a dual pentium?

For phase1 through phase4, no difference, the startup code is almost
entirely sequential and uses one cpu.  After phase4 and into the
compile steps, more processors are better.

