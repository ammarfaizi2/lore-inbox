Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVD2VFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVD2VFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVD2VES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:04:18 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:40525 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262978AbVD2VAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:00:25 -0400
Date: Fri, 29 Apr 2005 23:00:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: [PATCH] preserve ARCH and CROSS_COMPILE in the build directory generated Makefile
Message-ID: <20050429210053.GC8699@mars.ravnborg.org>
References: <200504291335.34210.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504291335.34210.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 01:35:33PM +0200, Pavel Pisa wrote:
> This patch ensures, that architecture and target cross-tools prefix
> is preserved in the Makefile generated in the build directory for
> out of source tree kernel compilation. This prevents accidental
> screwing of configuration and builds for the case, that make without
> full architecture specific options is invoked in the build
> directory. It is secure use accustomed "make", "make xconfig",
> etc. without fear and special care now.

Hi Pavel.
I will not apply this path because it introduce a difference when
building usign a separate output direcory compared to an in-tree build.

I have briefly looked into a solution where I could add this information
in .config but was sidetracked by other stuff so I newer got it working.

The build system for the kernel needs to be as predictable as possible
and introducing functionality that is only valid when using a separate
output directory does not help here.

	Sam
