Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUDGOZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUDGOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:25:07 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:38069 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263676AbUDGOZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:25:01 -0400
Date: Wed, 7 Apr 2004 16:24:59 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040407142459.GA31104@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk> <20040407064637.GB28941@MAIL.13thfloor.at> <20040407084722.GQ31500@parcelfarce.linux.theplanet.co.uk> <20040407101912.GA29900@MAIL.13thfloor.at> <20040407124641.GR31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407124641.GR31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:46:41PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > >> simple, to match the MS_* counterparts, something which
> > >> actually confused me in the first place (in the code)
> > 
> > so is this okay? actually I'd prefer to use the same
> > values for the MNT_NOATIME and MNT_NODIRATIME too ...
> > (as in the previous version I did)
> 
> Hmm...  Potentially we are breaking ABI for no good reason, since these
> defines are visible to out-of-tree code.  I don't think that we should
> care about matching MS_... stuff, simply because MS_... encoding is ugly
> as hell and there's no reason to use MNT_... and MS_... in the same
> context.

hmm, well breaking ABI here should not hurt anywhere, as 
they are 'just' defined flags, and no code should rely on the
actual values (or if it does, it is broken anyway, right?)

but if you 'think' that it will break something, it's okay
for me to keep the 'old' values ... and 'just' add new ones
for RDONLY, NOATIME, and NODIRATIME ...

best,
Herbert

