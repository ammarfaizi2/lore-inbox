Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVAPQJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVAPQJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVAPQJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:09:47 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:33347 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262529AbVAPQJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:09:34 -0500
Date: Sun, 16 Jan 2005 17:09:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cross-compilation broken (was: Re: Linux 2.6.11-rc1)
Message-ID: <20050116160948.GA3090@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <Pine.GSO.4.61.0501161016240.25137@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0501161016240.25137@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 10:22:43AM +0100, Geert Uytterhoeven wrote:
> Changing
> 
> | NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> 
> to
> 
> | NOSTDINC_FLAGS = -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> 
> fixed it. I guess it picked up the definition for $(CC) before it became
> $(CROSS_COMPILE)gcc.

Main culprint here is m68k fiddelign with definition of CROSS_COMPILE in
arch/m68k/Makefile.
If I find no better fix I will take your version.

	Sam
