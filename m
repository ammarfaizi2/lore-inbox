Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWHJXwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWHJXwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWHJXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:52:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12189 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932331AbWHJXwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:52:38 -0400
Date: Fri, 11 Aug 2006 09:52:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: XFS warning in 2.6.18-rc4
Message-ID: <20060811095210.I2596458@wobbly.melbourne.sgi.com>
References: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee> <20060810085616.C2581413@wobbly.melbourne.sgi.com> <9a8748490608101647l4f51e761o6dc1f703c9d012b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608101647l4f51e761o6dc1f703c9d012b2@mail.gmail.com>; from jesper.juhl@gmail.com on Fri, Aug 11, 2006 at 01:47:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 01:47:43AM +0200, Jesper Juhl wrote:
> On 10/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Wed, Aug 09, 2006 at 11:04:53PM +0300, Meelis Roos wrote:
> > > fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
> > > fs/xfs/xfs_bmap.c:2662: warning: 'rtx' is used uninitialized in this function
> >
> > You have a particularly dense compiler, unfortunately.  This code
> > has always been this way, its just a false cc warning that can be
> > safely ignored until you upgrade to a fixed compiler (unless I'm
> > missing something - please enlighten me if so).  It does seem to
> > be the case that there is no way 'rtx' will be used uninitialised
> > when xfs_rtpick_extent() doesn't fail... no?
> >
> Ok, I may be reading something wrong here, but I think the warning is
> actually not correct.

Thats how I read it too.  By "dense" I meant "buggy".

> Or am I missing something ?

Nope, thats my understanding too.  The compiler is wrong in this case.
The only open issue I guess is whether its worh rearranging the code
to stop people reporting it as a problem...  *shrug*.

cheers.

-- 
Nathan
