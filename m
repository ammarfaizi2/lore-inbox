Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCABh4>; Wed, 28 Feb 2001 20:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRCABhm>; Wed, 28 Feb 2001 20:37:42 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129460AbRCAB2Y>;
	Wed, 28 Feb 2001 20:28:24 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs patch for linux-2.4.2 
In-Reply-To: Your message of "Wed, 28 Feb 2001 20:27:33 BST."
             <20010228202733.A18073@caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Mar 2001 11:01:59 +1100
Message-ID: <20472.983404919@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001 20:27:33 +0100, 
Christoph Hellwig <hch@ns.caldera.de> wrote:
>Urgg. limits.h is a userlevel header...
>
>The attached patch will make similar atempts fail (but not this one as
>there is also a limits.h in gcc's include dir).
>
>--- linux-2.4.0/Makefile	Mon Dec 25 19:21:14 2000
>-CPPFLAGS := -D__KERNEL__ -I$(HPATH)
>+GCCINCDIR = $(shell gcc -print-search-dirs | sed -ne 's/install: \(.*\)/\1include/gp')
>+CPPFLAGS := -D__KERNEL__ -nostdinc -I$(HPATH) -I$(GCCINCDIR)

cc: trimmed to l-k.

CPPFLAGS apply to the kernel compiler which can be a cross compiler but
you are extracting data from the host gcc.  What exactly are you trying
to do here?  Are you trying to prevent the use of user space includes
or are you trying to pick up the cross compiler includes?

