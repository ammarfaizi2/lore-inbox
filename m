Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbULZDQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbULZDQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 22:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbULZDQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 22:16:37 -0500
Received: from holomorphy.com ([207.189.100.168]:47302 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261607AbULZDQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 22:16:36 -0500
Date: Sat, 25 Dec 2004 19:16:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041226031620.GB771@holomorphy.com>
References: <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <m1652q2fz1.fsf@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1652q2fz1.fsf@clusterfs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
[...]
>> Lifting the artificial lowmem restrictions on blockdev mappings
>> (thereby nuking mapping->gfp_mask altogether) would resolve a number of
>> problems, not that anything making that much sense could ever happen.

On Sun, Dec 26, 2004 at 01:03:14AM +0300, Nikita Danilov wrote:
> mapping->gfp_mask is used for other things beyond specifying a
> zonelist. For example, file systems want all allocations inside a
> transaction to be done with GFP_NOFS, which forces GFP_NOFS in
> mapping->gfp_mask of meta-data address_spaces.

It's news to me, but benign. ->gfp_mask appears to be folded into
some bitflag word now so there wouldn't be an inode size reduction
anyway. Per-mapping gfp masks sound like a poor fit from the above.


-- wli
