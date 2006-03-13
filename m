Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWCMWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWCMWQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWCMWQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:16:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37391 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964784AbWCMWQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:16:53 -0500
Date: Mon, 13 Mar 2006 23:16:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>, Andi Kleen <ak@suse.de>,
       Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [patch] Require VM86 with VESA framebuffer
Message-ID: <20060313221651.GO13973@stusta.de>
References: <200603131159_MC3-1-BA89-78CA@compuserve.com> <4415A586.1010404@linux.intel.com> <200603131358.50374.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131358.50374.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 01:58:49PM -0800, Jesse Barnes wrote:
> On Monday, March 13, 2006 9:01 am, Arjan van de Ven wrote:
> > Chuck Ebbert wrote:
> > > In-Reply-To: <1142261096.25773.19.camel@localhost.localdomain>
> > > References: <1142261096.25773.19.camel@localhost.localdomain>
> > >
> > > On Mon, 13 Mar 2006 14:44:56 +0000, Alan Cox wrote:
> > >> VESA does not require VM86 so this change is completely wrong.
> > >
> > > What is this all about then?
> >
> > that is about X requiring it. Not about anything kernel related.
> 
> And X doesn't actually require it, it's just that some builds of the X 
> int10 and VBE libraries assume it's available.  They can be configured 
> to use an x86 emulator instead, and probably should be by default so 
> that non-x86 systems have a better chance of working (code coverage and 
> all that).

You can only disable CONFIG_VM86 if you have set CONFIG_EMBEDDED=y.

That's OK considering that CONFIG_EMBEDDED=y has the semantics:
  Allow me to disable more options to save space no matter how much
  this can break since I do _really_ know what I'm doing when I'm 
  enabling CONFIG_EMBEDDED.

Expecting working kernels when randomly toggling options that get 
available with CONFIG_EMBEDDED=y is simply silly.

> Jesse

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

