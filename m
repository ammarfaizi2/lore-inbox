Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbUKLPUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUKLPUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUKLPU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:20:29 -0500
Received: from nevyn.them.org ([66.93.172.17]:60115 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262550AbUKLPUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:20:25 -0500
Date: Fri, 12 Nov 2004 10:20:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
Message-ID: <20041112152020.GB26482@nevyn.them.org>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20041112145733.GA26482@nevyn.them.org> <20041101162929.63af1d0d.akpm@osdl.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com> <5109.1099394496@redhat.com> <24825.1100272518@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24825.1100272518@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 03:15:18PM +0000, David Howells wrote:
> 
> > FYI, "gcc -g" _should_ cause .S files to include assembler debugging
> > information.  If it doesn't, that's a bug in your port.
> 
> It appears you may have a point. Running FRV compiler with gcc -g on a .S file
> does not pass any sort of -g flag to the assembler. It does with the i386
> compiler.

You're probably not selecting the right assembler to feature-test at
build time.  Check these:
     && defined(HAVE_AS_GDWARF2_DEBUG_FLAG) && defined(HAVE_AS_GSTABS_DEBUG_FLAG)

-- 
Daniel Jacobowitz
