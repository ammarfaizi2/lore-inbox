Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTDUSJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTDUSJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:09:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15294 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261824AbTDUSJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:09:56 -0400
Date: Mon, 21 Apr 2003 19:21:58 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421182158.GM10374@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0304211354280.12110-100000@serv> <Pine.LNX.4.44.0304211056210.3101-100000@home.transmeta.com> <20030421191013.A9655@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421191013.A9655@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 07:10:13PM +0100, Christoph Hellwig wrote:
> On Mon, Apr 21, 2003 at 11:01:21AM -0700, Linus Torvalds wrote:
> > Oh, the split has huge meaning inside the kernel. We split the number 
> > every time we open the device, and use that split to look up the result.
> 
> Not anymore for blockdevices.  And now that Al's back not anymore soon
> for charater devices, too :)

Oh, we certainly _do_ split - simply because there are ranges that
belong to same driver (or driver and object).

	However, the split boundary is not uniform - it depends on
driver/object/whatnot.  IMO it's a moot point by now, anyway - most
of the kernel couldn't care less about device numbers.
