Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTBOV3d>; Sat, 15 Feb 2003 16:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTBOV3d>; Sat, 15 Feb 2003 16:29:33 -0500
Received: from ns.suse.de ([213.95.15.193]:32266 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265171AbTBOV3c> convert rfc822-to-8bit;
	Sat, 15 Feb 2003 16:29:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Date: Sat, 15 Feb 2003 22:39:24 +0100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       "Theodore T'so" <tytso@mit.edu>
References: <200302112018.58862.agruen@suse.de> <200302152017.03259.agruen@suse.de> <20030215210922.A24685@infradead.org>
In-Reply-To: <20030215210922.A24685@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302152239.24346.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 February 2003 22:09, Christoph Hellwig wrote:
> On Sat, Feb 15, 2003 at 08:17:03PM +0100, Andreas Gruenbacher wrote:
> > That sounds quite reasonable. I would have to raise CAP_SYS_ADMIN
> > for trusted EA's, though. Do you see any potential side effects
> > while a pretty powerful capability like CAP_SYS_ADMIN is
> > temporarily raised?
>
> Okay, something I missed when looking over your patches, otherwise
> I'd have shutde earlier :)  Do you really think you want
> CAP_SYS_ADMIN for trusted EAs?  Soon we'll get CAP_SYS_ADMIN as
> catchall like old suser()..
>
> Let me check what XFS uses for that purpose as soon as I'm back in
> the office.

The intention of Trusted Extended Attributes is for processes that 
perform tasks that are relevant for the proper functioning of the 
system, to allow them to use EAs. Other, non-privileged processes shall 
have no access whatsoever to those EAs. This level of protection would 
otherwise only be possible by providing a kernel module. 

I would be quite happy with a new CAP_TRUSTED_PROCESS or whatever, but 
going that route for all sorts of applications then we might soon end 
up with an large number of capabilities. Maybe I'm wrong on that, 
though.


Cheers,
Andreas.

