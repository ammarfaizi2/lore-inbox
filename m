Return-Path: <linux-kernel-owner+w=401wt.eu-S932697AbXARWzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbXARWzL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbXARWzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:55:10 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:36265 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932697AbXARWzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:55:08 -0500
Date: Fri, 19 Jan 2007 00:55:00 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: David Chinner <dgc@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs-masters@oss.sgi.com
Subject: Re: 2.6.20-rc5: known unfixed regressions
Message-ID: <20070118225500.GC16110@m.safari.iki.fi>
Mail-Followup-To: David Chinner <dgc@sgi.com>, Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs-masters@oss.sgi.com
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070113071125.GG7469@stusta.de> <20070116061502.GP44411608@melbourne.sgi.com> <20070117034329.GW44411608@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117034329.GW44411608@melbourne.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 14:43:29 +1100, David Chinner wrote:
...
> > > Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
> > > References : http://lkml.org/lkml/2007/1/5/308
> > > Submitter  : Sami Farin <7atbggg02@sneakemail.com>
> > > Handled-By : David Chinner <dgc@sgi.com>
> > > Status     : problem is being discussed
> > 
> > I'm at LCA and been having laptop dramas so the fix is being held up at this
> > point. I and trying to test a change right now that adds an optional unmap
> > to truncate_inode_pages_range as XFS needs, in some circumstances, to toss
> > out dirty pages (with dirty bufferheads) and hence requires truncate semantics
> > that are currently missing unmap calls.
> > 
> > Semi-untested patch attached below.
> 
> The patch has run XFSQA for about 24 hours now on my test rig without
> triggering any problems.

I have also ran this for 24h (in patched 2.6.19.2)
and no problems noticed :)

-- 
Do what you love because life is too short for anything else.

