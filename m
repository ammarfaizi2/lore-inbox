Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbUDNPYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUDNPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:24:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36836 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264259AbUDNPYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:24:21 -0400
Date: Wed, 14 Apr 2004 16:24:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: raven@themaw.net
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
Message-ID: <20040414152420.GE31500@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain> <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net> <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404142023460.1537@donald.themaw.net> <Pine.LNX.4.58.0404142308260.20568@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404142308260.20568@donald.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 11:13:13PM +0800, raven@themaw.net wrote:
> On Wed, 14 Apr 2004 raven@themaw.net wrote:
> 
> > > Mind you, chdir() patch in -mm is broken in a lot of other ways - e.g.
> > > it assumes that another thread sharing ->fs with us won't call chdir()
> > > in the wrong moment...
> > 
> > Thanks for your interest Al.
> > 
> > I see your point (I think).
> > 
> > If I understand you correctly (please explain if I don't) I need to lock 
> > the ->fs struct.
> 
> Mmm ... doesn't look much good in the light of Als comment.
> 
> Looks like it's not possible to take the lock for long enough even if I 
> could.
> 
> Lets have some comments, criticisms or suggestions please.

Why do you need to assign pwd before revalidation?
