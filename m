Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264450AbRFOQuQ>; Fri, 15 Jun 2001 12:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264453AbRFOQt5>; Fri, 15 Jun 2001 12:49:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51980 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264450AbRFOQts>;
	Fri, 15 Jun 2001 12:49:48 -0400
Date: Fri, 15 Jun 2001 17:49:46 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Final call for testers][PATCH] superblock handling changes (2.4.6-pre3)
Message-ID: <20010615174946.D9522@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010615171632.C9522@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.21.0106151221190.8909-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0106151221190.8909-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jun 15, 2001 at 12:34:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 12:34:41PM -0400, Alexander Viro wrote:
> Aside of the missing ->s_count++ - no arguments.

My mistake.

> > > +	list_add (&s->s_list, super_blocks.prev);
> > 
> > I'd use list_add_tail(&s->s_list, super_blocks);
> 
> Umm... Why? I've no problems with either variant, but I really see no
> clear win (or loss) in list_add_tail here. If there is some code that
> relies on the order in that list it's badly broken - remember, we used
> to reuse unmounted superblocks, so order might be almost arbitrary.

It does exactly the same thing -- inserting at the end of the list --
just slightly more obvious what its doing.

-- 
Revolutions do not require corporate support.
