Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTIILkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTIILkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:40:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23479 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264029AbTIILkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:40:10 -0400
Date: Tue, 9 Sep 2003 13:40:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030909114014.GG4755@suse.de>
References: <20030907062248.GX18654@parcelfarce.linux.theplanet.co.uk> <20030908123846.GA15553@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908123846.GA15553@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08 2003, Andries Brouwer wrote:
> On Sun, Sep 07, 2003 at 07:22:48AM +0100, Matthew Wilcox wrote:
> 
> > Clearly it's too late to change the ioctl definitions, but we can at
> > least stop people from copying them and making the same mistake.
> 
> > -#define BLKELVSET  _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))/* elevator set */
> > +#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */
> 
> Here we lose information - I don't like that.
> Often it is important to know what kind of argument an ioctl has,
> and that info should be easy to find.

Just kill them, they are not used.

-- 
Jens Axboe

