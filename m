Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbVKXF3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbVKXF3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbVKXF3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:29:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:1478 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030607AbVKXF3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:29:37 -0500
From: Neil Brown <neilb@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Date: Thu, 24 Nov 2005 16:29:28 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17285.20408.500921.973650@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, sander@humilis.net,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Please help me understand ->writepage. Was Re: segfault mdadm
 --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
In-Reply-To: message from Anton Altaparmakov on Tuesday November 22
References: <431B9558.1070900@baanhofman.nl>
	<17179.40731.907114.194935@cse.unsw.edu.au>
	<20051116133639.GA18274@favonius>
	<20051116142000.5c63449f.akpm@osdl.org>
	<17275.48113.533555.948181@cse.unsw.edu.au>
	<20051117075041.GA5563@favonius>
	<20051117101251.GA2883@favonius>
	<20051117101511.GB2883@favonius>
	<17282.21309.229128.930997@cse.unsw.edu.au>
	<20051121155144.62bedaab.akpm@osdl.org>
	<17282.35980.613583.592130@cse.unsw.edu.au>
	<Pine.LNX.4.64.0511221153430.2763@hermes-1.csi.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 22, aia21@cam.ac.uk wrote:
> On Tue, 22 Nov 2005, Neil Brown wrote:
> > I've made them all kmap_atomic.
> 
> Except you did it wrong...  See below...
> 
> > -	kunmap(bitmap->sb_page);
> > +	kunmap_atomic(bitmap->sb_page, KM_USER0);
> 
> You need to pass in the address not the page, i.e.:
> 

How.. umm... intuitive :-(
Thanks, I'll fix that.

> 
> Hope this helps.
> 

It does.  I really appreciate getting feedback on my code.... I've
sometimes tempted to slip in a few bugs so that when people point them
out to me I know they have read the rest of the code and that
increases my confidence in it (I haven't actually done this... yet).

:-)

NeilBrown
