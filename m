Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUBVRHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUBVRHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:07:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:11650 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261697AbUBVRHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:07:21 -0500
Date: Sun, 22 Feb 2004 18:07:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Jim Wilson <wilson@specifixinc.com>, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222170720.GA24703@MAIL.13thfloor.at>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222155209.GA11162@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222155209.GA11162@linux-sh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 10:52:09AM -0500, Paul Mundt wrote:
> On Sun, Feb 22, 2004 at 04:53:50AM +0100, Herbert Poetzl wrote:
> >    			   linux-2.6.3-rc3     linux-2.6.3
> >    			   config  build       config  build
> > 
> >    sh/sh:		   OK	   FAILED      OK      FAILED
> >    sh64/sh:		   OK	   FAILED      OK      FAILED
> 
> sh64 doesn't exist in 2.6 yet, attempting to build a kernel 
> for it is futile.

hmm, I guess that explains the sh64/sh build failure ... ;)

but why does the sh/sh case fail?

> >    others seem to require different? binutils (sh and sh64)
> >    
> sh and sh64 require completely different toolchains. 
> They're very different platforms, and have very little in common.

okay, binutils and gcc seem to 'know' sh and sh64 as 
architectures, (in my case binutils 2.14.90.0.8, and 
gcc 3.3.2, w/o any patches), what binutils/gcc would
you suggest for building sh or sh64?

> >    				   linux-2.4.25
> >    			   config  dep     kernel  modules
> > 
> >    sh/sh:		   OK	   OK	   FAILED  FAILED
> 
> These are due to erroring on .rept usage for filling in the 
> sys_call_table in arch/sh/kernel/entry.S, in 2.6 we've already 
> cleaned this up in the LinuxSH tree by just dropping it and 
> padding out for NR_syscalls, I suppose something similar will 
> have to be done in the 2.4 case..
> 
> >    sh64/sh64:		   OK	   OK	   FAILED  FAILED
> > 
> The sh64 build errors according to logs[7] are issues with your 
> toolchain, binutils in particular.

is there a toolchain/binutils which 'know' and 'support'
the '-isa=sh64' option? maybe it was depreciated?

gcc -isa=sh64 x.c
cc1: error: unrecognized option `-isa=sh64'

thanks for your input, I honestly appreciate it,

TIA,
Herbert


