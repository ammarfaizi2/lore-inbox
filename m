Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbRLCIvt>; Mon, 3 Dec 2001 03:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284388AbRLCIt7>; Mon, 3 Dec 2001 03:49:59 -0500
Received: from rj.SGI.COM ([204.94.215.100]:21984 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284531AbRLCAza>;
	Sun, 2 Dec 2001 19:55:30 -0500
Date: Mon, 3 Dec 2001 11:54:01 +1100
From: Nathan Scott <nathans@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011203115400.F39338@wobbly.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <20011114230134.A5739@lynx.no> <20011116101800.A632931@wobbly.melbourne.sgi.com> <E16Agdh-0000BS-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Agdh-0000BS-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Dec 03, 2001 at 01:07:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Daniel,

On Mon, Dec 03, 2001 at 01:07:13AM +0100, Daniel Phillips wrote:
> Hi, sorry for jumping into this a little late, but...
> 

No problem.  BTW, we have reworked the interfaces once more and
will send out the latest revision in the next couple of days -
it does away with commands and flags completely, except for this
one instance of flags in the set operation...

> On November 16, 2001 12:18 am, Nathan Scott wrote:
> > > What is the distinction between "set" and "replace" or "set" and "create"?
> > 
> > +#define EA_CREATE   0x0001  /* Set the value: fail if attr already exists */
> > +#define EA_REPLACE  0x0002  /* Set the value: fail if attr does not exist */
> > 
> > Whereas "set" is simply set the named attribute value, creating the
> > attribute if need be, replacing the value if the attribute exists,
> > and then return success.
> 
> What is the purpose of these distinctions?  Does anyone rely on them?  Do such
> distinctions exist in an existing implementation?
> 

The purpose is to provide user tools with more control over the
creation or updating of an attribute and its value.  I don't think
the replace flag is very widely used, but I have seen the create
flag used in places - eg. the XFS fsr tool uses that flag.

The IRIX extended attribute interfaces provide these flags - Andreas
has also examined the implementations, man pages, etc, of several other
operating systems, so he'll be able to tell us if any others provide
this sort of thing too.

cheers.

-- 
Nathan
