Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVADViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVADViT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVADVgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:36:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:40403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVADVbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:31:10 -0500
Date: Tue, 4 Jan 2005 13:31:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050104133108.W2357@build.pdx.osdl.net>
References: <20050102200032.GA8623@lst.de> <1104870292.8346.24.camel@krustophenia.net> <Pine.LNX.4.58.0501041303190.2294@ppc970.osdl.org> <20050104210812.GA16420@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104210812.GA16420@lst.de>; from hch@lst.de on Tue, Jan 04, 2005 at 10:08:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@lst.de) wrote:
> On Tue, Jan 04, 2005 at 01:05:29PM -0800, Linus Torvalds wrote:
> > On Tue, 4 Jan 2005, Lee Revell wrote:
> > > And I posted this to LKML almost a week ago, and a real fix was posted
> > > in response.
> > > 
> > > http://lkml.org/lkml/2004/12/28/112
> > 
> > Well, I realize that it has been on bugtraq, but does that make it a real 
> > concern? I'll make the tristate a boolean, but has anybody half-way sane 
> > ever _done_ what is described by the bugtraq posting? IOW, it looks pretty 
> > much like a made-up example, also known as a "don't do that then" kind of 
> > buglet ;)
> 
> I don't think this particular one is too serious.  But I think we'll see
> more serious issues with other modular security modules.

It's only a problem when you care about the state of things that have
run before the module is loaded.  This ranges between no problem and
major problem on a case by case basis.  For example, really makes sense
to have SELinux only compiled in.  For this one, we can just track
capabilities bits in default dummy stub code, it's painless and allows
keeping capabilities modular for those who use it that way.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
