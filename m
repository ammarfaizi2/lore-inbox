Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270017AbUIDBFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270017AbUIDBFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270012AbUIDBDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:03:08 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:57007 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S270038AbUIDA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:57:07 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christoph Hellwig <hch@lst.de>
Date: Sat, 4 Sep 2004 10:56:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16697.4817.621088.474648@cse.unsw.edu.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bug in md write barrier support?
In-Reply-To: message from Christoph Hellwig on Friday September 3
References: <20040903172414.GA6771@lst.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 3, hch@lst.de wrote:
> md_flush_mddev just passes on the sector relative to the raid device,
> shouldn't it be translated somewhere?

Yes.  md_flush_mddev should simply be removed.  
The functionality should be, and largely is, in the individual
personalities. 

Is there documentation somewhere on exactly what an issue_flush_fn
should do (is it  allowed to sleep? what must happen before it is
allowed to return, what is the "error_sector" for,  that sort of thing).

I suspect that at least raid5 will need some fairly special handling.

NeilBrown
