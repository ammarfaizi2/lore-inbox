Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUEWAUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUEWAUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 20:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUEWAUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 20:20:54 -0400
Received: from mx02.qsc.de ([213.148.130.14]:22144 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261992AbUEWAUx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 20:20:53 -0400
Date: Sun, 23 May 2004 02:20:31 +0200 (CEST)
Message-Id: <20040523.022031.291474063.rene@rocklinux-consulting.de>
To: hch@lst.de
Cc: akpm@osdl.org, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <20040522234059.GA3735@infradead.org>
References: <20040522234059.GA3735@infradead.org>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Sun, 23 May 2004 01:40:59 +0200, Christoph
	Hellwig <hch@lst.de> wrote: > These days gcc uses i486+ only
	instruction by default in libstdc++ so > most modern distros wouldn't
	work on i386 cpus anymore. To make it work > again Debian merged Willy
	Tarreau's patch to trap those and emulate them > on real i386 cpus. The
	patch is extremely non-invasive and would > certainly be usefull for
	mainline. Any reason not to include it? [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Sun, 23 May 2004 01:40:59 +0200,
    Christoph Hellwig <hch@lst.de> wrote:
> These days gcc uses i486+ only instruction by default in libstdc++ so
> most modern distros wouldn't work on i386 cpus anymore.  To make it work
> again Debian merged Willy Tarreau's patch to trap those and emulate them
> on real i386 cpus.  The patch is extremely non-invasive and would
> certainly be usefull for mainline.  Any reason not to include it?

Oh cool! Given the fact with libstdc++ and sparc32 kernel also always
contain code to emulatre the mul/div instructions missing in the v7
hardware (just foudn this SIGILL trap by accident recently ..) the
comment might be a bit too strict. Maybe something like written in the
MATH_EMULATION config:

"If you are not sure, say Y; apart from resulting in a 66 KB bigger
kernel, it won't hurt."

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

