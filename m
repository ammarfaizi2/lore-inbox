Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbTCGPcm>; Fri, 7 Mar 2003 10:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbTCGPcl>; Fri, 7 Mar 2003 10:32:41 -0500
Received: from havoc.daloft.com ([64.213.145.173]:28353 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261641AbTCGPcl>;
	Fri, 7 Mar 2003 10:32:41 -0500
Date: Fri, 7 Mar 2003 10:43:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Arun Prasad <arun@netlab.hcltech.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5.51 CRC32 undefined
Message-ID: <20030307154303.GA21502@gtf.org>
References: <1047040816.32200.59.camel@passion.cambridge.redhat.com> <Pine.LNX.4.44.0303070922580.26430-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303070922580.26430-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 7 Mar 2003, David Woodhouse wrote:
> > The problem is that crc32.o isn't actually linked into the kernel,
> > because no symbols from it are referenced when the linker is asked to
> > pull in lib/lib.a
> > 
> > Set CONFIG_CRC32=m. We probably shouldn't allow it to be set to 'Y' in
> > the first place., given the above.

The solution is to fix the problem, not force a module.

There are weirdos like Linus that don't use modules at all, and
other developers who still don't use modules due to the module
loader changes...

	Jeff




