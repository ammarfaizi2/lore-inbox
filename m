Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWGRAsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGRAsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWGRAsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:48:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:28378 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbWGRAso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:48:44 -0400
From: Neil Brown <neilb@suse.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 18 Jul 2006 10:48:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17596.12231.468729.199881@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Raid5 Reshape Status + xfs_growfs = Success! (2.6.17.3)
In-Reply-To: message from Justin Piszcz on Tuesday July 11
References: <Pine.LNX.4.64.0607111159470.12230@p34.internal.lan>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 11, jpiszcz@lucidpixels.com wrote:
> Neil,
> 
> It worked, echo'ing the 600 > to the stripe width in /sys, however, how 
> come /dev/md3 says it is 0 MB when I type fdisk -l?
> 
> Is this normal?

Yes.  The 'cylinders' number is limited to 16bits.  For you 2.2TB
array, the number of 'cylinders' (given 2 heads and 4 sectors) would
be about 500,000 which doesn't fit into 16 bits.
> 
> Furthermore, the xfs_growfs worked beautifully!
> 

Excellent!

NeilBrown
