Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUHYVPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUHYVPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268739AbUHYVA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:00:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28041 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268662AbUHYVAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:00:04 -0400
Date: Wed, 25 Aug 2004 21:59:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825205957.GJ21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de> <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:24:36PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 25 Aug 2004, Christoph Hellwig wrote:
> > 
> > Over the last at least five years we've taken as much as possible
> > semantics out of the filesystems and into the VFS layer, thus having
> > a separation between the semantical layer (VFS) and the low level
> > filesystem.  Your attributes are absoultely a VFS thing and as such
> > should not happen at the filesystem layer, and no, that doesn't mean
> > they're bad per se, I just think they are a rather bad fit for Linux.
> 
> Now this I agree with, in the sense that I think that if we want to 
> support this, it should be supported at a VFS layer. 

ACK.  However, I'm still not seeing *ANYTHING* that would look like a workable
scheme in presense of hardlinks.  Show me how to make that deadlock- and
race-free and we might very well do it in VFS.

_That_ is what's missing and it's needed no matter where it's implemented.
You want hybrid objects - you want to solve that one.  So far I've seen
nothing workable.
