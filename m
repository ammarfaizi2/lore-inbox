Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbRFZXuC>; Tue, 26 Jun 2001 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265157AbRFZXty>; Tue, 26 Jun 2001 19:49:54 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:52684 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S264733AbRFZXtr>;
	Tue, 26 Jun 2001 19:49:47 -0400
Date: Tue, 26 Jun 2001 19:49:19 -0400
From: Theodore Tso <tytso@valinux.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Tony Gale <gale@syntax.dera.gov.uk>, Heusden@mail.bonn-fries.net,
        Folkert van <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
Message-ID: <20010626194919.J537@think.thunk.org>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Andreas Dilger <adilger@turbolinux.com>,
	Tony Gale <gale@syntax.dera.gov.uk>, Heusden@mail.bonn-fries.net,
	Folkert van <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net,
	Alexander Viro <viro@math.psu.edu>
In-Reply-To: <200106251951.f5PJpOYN025503@webber.adilger.int> <01062600253207.01008@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <01062600253207.01008@starship>; from phillips@bonn-fries.net on Tue, Jun 26, 2001 at 12:25:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 12:25:32AM +0200, Daniel Phillips wrote:
> > This is only true without the COMPAT_DIR_INDEX flag.  Since e2fsck _needs_
> > to know about every filesystem feature, it will (correctly) refuse to touch
> > such a system for now.  You could "tune2fs -O ^FEATURE_C4 /dev/hdX" to
> > turn of the COMPAT_DIR_INDEX flag and let e2fsck go to town.  That will
> > break all of the directory indexes, I believe.
> 
> This is what he wants, a workaround so he can fsck.  However, the above 
> command (on version 1.2-WIP) just gives me:
> 
>    Invalid filesystem option set: ^FEATURE_C4
> 
> Maybe he should just edit the source so it doesn't set the superblock flag 
> for now.

I haven't had a chance to analyze the directory index format to see if
an-dirindexing-ignorant e2fsck could do any damage to the index.  It's
probably the case as long as the filesystem isn't corrupted, simply
modifying e2fsck to ignore the compatibility flag won't hurt.  But
it's certainly not something I would recommend for any kind of
production operation.

						- Ted

