Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267858AbTB1NNM>; Fri, 28 Feb 2003 08:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTB1NNM>; Fri, 28 Feb 2003 08:13:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46348 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267858AbTB1NNL>; Fri, 28 Feb 2003 08:13:11 -0500
Date: Fri, 28 Feb 2003 14:23:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ben Collins <bcollins@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030228132330.GC8498@atrey.karlin.mff.cuni.cz>
References: <20030227203440.GP21100@phunnypharm.org> <20030227.122126.30208201.davem@redhat.com> <20030227205044.GQ21100@phunnypharm.org> <20030227.123701.16257819.davem@redhat.com> <20030227211256.GR21100@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227211256.GR21100@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    > Well, you just doubled the size of the table on sparc64.
> >    > I don't know if I like that.
> >    
> >    Not much of a way around it.
> > 
> > Such problems are only in your mind. :-)
> > 
> > What's wrong with defining the type and accessor macros
> > in include/asm/compat.h?
> 
> One thing I am just now wondering is why struct ioctl_trans defines cmd
> as an unsigned long instead of just unsigned int. That adds an uneeded
> bit of space to the array.

Do you think so?

cmd probably could be u32 (since it is ioctl32 after all), but I doubt
it matters, as two following entries are pointers so it looks to me
like it is going to be lost by alignment, anyway.

> As for your suggestion, sounds great, but I'll leave it to Pavel :)

First things first, patch probably still breaks all other
architectures than x86-64 and sparc64....
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
