Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVAMRwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVAMRwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVAMRvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:51:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:47046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261256AbVAMRtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:49:45 -0500
Date: Thu, 13 Jan 2005 09:49:42 -0800
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113094942.R24171@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105632757.4624.59.camel@localhost.localdomain> <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>; from torvalds@osdl.org on Thu, Jan 13, 2005 at 09:33:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Thu, 13 Jan 2005, Alan Cox wrote:
> >
> > On Iau, 2005-01-13 at 16:38, Linus Torvalds wrote:
> > > It wouldn't be a global flag. It's a per-process flag. For example, many 
> > > people _do_ need to execute binaries in their home directory. I do it all 
> > > the time. I know what a compiler is.
> > 
> > noexec has never been worth anything because of scripts. Kernel won't
> > load that binary, I can write a script to do it.
> 
> Scripts can only do what the interpreter does. And it's often a lot harder
> to get the interpreter to do certain things. For example, you simply
> _cannot_ get any thread race conditions with most scripts out there, nor 
> can you generally use magic mmap patterns.

I think perl has threads and some type of free form syscall ability.
Heck, with a legit elf binary and gdb you can get a long ways.  But I
agree in two things.  1) It's all about layers, since there is no silver
bullet, and 2) Containment goes a long ways to mitigate damage.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
