Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVAHTmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVAHTmg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 14:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVAHTmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 14:42:36 -0500
Received: from [213.146.154.40] ([213.146.154.40]:37075 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261286AbVAHTme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 14:42:34 -0500
Date: Sat, 8 Jan 2005 19:42:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Export get_sb_pseudo()?
Message-ID: <20050108194231.GA32285@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
References: <52k6qn229h.fsf@topspin.com> <20050108193101.GD26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108193101.GD26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 07:31:01PM +0000, Al Viro wrote:
> On Sat, Jan 08, 2005 at 10:40:10AM -0800, Roland Dreier wrote:
> > I'm planning on implementing some modular driver code and I think it
> > makes sense to have a non-mountable pseudofs.  Especially with the
> > recent MVFS controversy, it seems prudent to find out whether this
> > usage would merit exporting get_sb_pseudo(), so I'll describe my
> > current plans below.
> 
> No objections; it certainly falls under "general-purpose library
> helper".  Moreover, in this case I _insist_ on use of normal
> export; it is a convenience helper that
> 	a) can be trivially reimplemented by anyone who cares; any
> number of filesystems is open-coding far more than that in their
> ->get_sb(), so there's nothing to protect here.
> 	b) can be trivially simulated by simple_fill_super() followed
> by a bit of tweaking the result.
> 	c) does not shove any pitchforks into the kernel guts - resulting
> superblock does not require any special treatment.

Agreed.

