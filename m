Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSEDNBc>; Sat, 4 May 2002 09:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312694AbSEDNBb>; Sat, 4 May 2002 09:01:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34577 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312691AbSEDNBa>;
	Sat, 4 May 2002 09:01:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.4 is available
In-Reply-To: Your message of "Sat, 04 May 2002 00:19:10 +1000."
             <13468.1020435550@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 23:01:17 +1000
Message-ID: <24512.1020517277@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 May 2002 00:19:10 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 2.4 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 2.4.

kbuild-2.5-core-11
  Changes from core-10.

    Redo the passing of kbuild variables to $(shell) commands.

    Require make 3.79.1 for kbuild 2.5.

The make 'export' command does not export the variables to $(shell)
commands, which makes it messy when those commands need to access the
variables.  The workaround for this was a bit hackish and a core-10
change broke with common source and object.

core-11 uses a new method of passing the kbuild variables to $(shell)
commands.  It is cleaner, but it requires features that are not
available in make 3.77.  make 3.78 should work but since 3.79.1 has
been out for almost two years and is being used by any recent
distribution, the code says that make 3.79.1 is required for kbuild
2.5.

An update to 2.5/Documentation/Changes has been submitted.  Linus has
already done 2.5 changes that require make 3.79 features, the Changes
update is overdue.

