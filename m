Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280743AbRKGDVh>; Tue, 6 Nov 2001 22:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKGDV2>; Tue, 6 Nov 2001 22:21:28 -0500
Received: from zok.SGI.COM ([204.94.215.101]:14794 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280663AbRKGDVY>;
	Tue, 6 Nov 2001 22:21:24 -0500
Date: Wed, 7 Nov 2001 14:19:56 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, acl-devel@bestbits.at,
        linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] extended attributes
Message-ID: <20011107141956.F591676@wobbly.melbourne.sgi.com>
In-Reply-To: <20011107111224.C591676@wobbly.melbourne.sgi.com> <20011107023218.A4754@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107023218.A4754@wotan.suse.de>; from ak@suse.de on Wed, Nov 07, 2001 at 02:32:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello again Andi,

On Wed, Nov 07, 2001 at 02:32:18AM +0100, Andi Kleen wrote:
> I think it would be better to have a statefull readdir instead.
> The kernel supports it via the ->private_data field of struct file
> (not through fork,but that looks like a generic vfs bug) 
> 
> EA_FIRST_ENTRY to reset the fd the first entry, EA_READ_ENTRY to 
> read the next one.

I'm not sure this would work for the extattr/lextattr variants where
we don't have an fd to hold the state.  Should the list operation
be restricted to the fextattr variant, perhaps?  I'm not sure about
all the implications of that, will have to see what everyone else
thinks I guess.

eg. the opening of the file before allowing a list operation could
have implications for XFSs DMAPI support (open might recall data from
tape), where the management tools need to be able to list these DMAPI
related attributes without affecting the backing storage, I believe -
I'll have to ask some DMAPI gurus about that one though.

Thanks for the input.

cheers.

-- 
Nathan
