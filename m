Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132518AbRCZSJN>; Mon, 26 Mar 2001 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132528AbRCZSJE>; Mon, 26 Mar 2001 13:09:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132518AbRCZSIx>;
	Mon, 26 Mar 2001 13:08:53 -0500
Date: Mon, 26 Mar 2001 19:07:33 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: matthew@wil.cx, law@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010326190733.H31126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <009201c0b61e$c83f7550$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <009201c0b61e$c83f7550$5517fea9@local>; from manfred@colorfullife.com on Mon, Mar 26, 2001 at 08:01:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 08:01:21PM +0200, Manfred Spraul wrote:
> drivers/block/ll_rw_blk.c, in submit_bh()
> >    bh->b_rsector = bh->b_blocknr * (bh->b_size >> 9);
> 
> But it shouldn't cause data corruptions:
> It was discussed a few months ago, and iirc LVM refuses to create too
> large volumes.

Ah yes, I'd forgotten the block layer still works in terms of 512-byte blocks.

-- 
Revolutions do not require corporate support.
