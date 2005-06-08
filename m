Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVFHUrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFHUrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVFHUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:47:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:8620 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261611AbVFHUpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:45:39 -0400
Date: Wed, 8 Jun 2005 22:45:33 +0200
From: Olaf Hering <olh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: arnd@arndb.de, torvalds@osdl.org, paulus@samba.org, akpm@osdl.org,
       anton@samba.org, linux-kernel@vger.kernel.org, jk@blackdown.de
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
Message-ID: <20050608204533.GA3305@suse.de>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org> <200506082049.51707.arnd@arndb.de> <20050608.121950.104038734.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050608.121950.104038734.davem@davemloft.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jun 08, David S. Miller wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 8 Jun 2005 20:49:48 +0200
> 
> > With the LINUX32 personality, you can build 32 bit binaries through
> > autoconf, rpmbuild, or the kernel without pretending to be
> > cross-compiling. It may not be the best solution, but people seem to
> > rely on it and the patch brings ppc64 in line with how it works on
> > the other architectures.
> 
> I totally agree, this has a large precedence on many platforms
> and there are even gcc frontends that check the uname output
> to decide what code model to output by default.

They (the auto* tools) should probably check for gcc -dumpmachine
instead for uname -m. Both have nothing in common, they just happen to
be equal on Walmart boxes.
