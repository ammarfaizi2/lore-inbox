Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVD2W1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVD2W1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVD2W1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:27:11 -0400
Received: from nevyn.them.org ([66.93.172.17]:42946 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263031AbVD2W1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:27:08 -0400
Date: Fri, 29 Apr 2005 18:26:56 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: [PATCH] preserve ARCH and CROSS_COMPILE in the build directory generated Makefile
Message-ID: <20050429222656.GA10964@nevyn.them.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kai@germaschewski.name
References: <200504291335.34210.pisa@cmp.felk.cvut.cz> <20050429210053.GC8699@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429210053.GC8699@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 11:00:53PM +0200, Sam Ravnborg wrote:
> On Fri, Apr 29, 2005 at 01:35:33PM +0200, Pavel Pisa wrote:
> > This patch ensures, that architecture and target cross-tools prefix
> > is preserved in the Makefile generated in the build directory for
> > out of source tree kernel compilation. This prevents accidental
> > screwing of configuration and builds for the case, that make without
> > full architecture specific options is invoked in the build
> > directory. It is secure use accustomed "make", "make xconfig",
> > etc. without fear and special care now.
> 
> Hi Pavel.
> I will not apply this path because it introduce a difference when
> building usign a separate output direcory compared to an in-tree build.
> 
> I have briefly looked into a solution where I could add this information
> in .config but was sidetracked by other stuff so I newer got it working.
> 
> The build system for the kernel needs to be as predictable as possible
> and introducing functionality that is only valid when using a separate
> output directory does not help here.

You could drop it into a file unrelated to .config or Makefile; that
might be simpler.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
