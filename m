Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTIIVQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTIIVQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:16:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:58897 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264053AbTIIVQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:16:41 -0400
Date: Tue, 9 Sep 2003 23:16:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, Jes Sorensen <jes@wildopensource.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
Message-ID: <20030909211636.GA4400@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	davidm@hpl.hp.com, Jes Sorensen <jes@wildopensource.com>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <16222.14136.21774.211178@napali.hpl.hp.com> <Pine.LNX.4.44.0309091329570.30594-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091329570.30594-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 01:33:51PM -0700, Linus Torvalds wrote:
> 
> Then, have a config-time "set the right symbolic link" the same way we do 
> for "include/asm/", so that we can have a set of _clean_ 
> compiler-dependent abstractions.

I would prefer to have a compiler.h like this:

#if COMPILER=GCC-2.95
#include <compiler_gcc295.h
#endif

#if COMPILER=INTEL
#include <compiler_intel.h>
#endif

Better one more indirection in a simple compiler.h file than another symlink.
Symlinks should be used in rare cases only.

	Sam
