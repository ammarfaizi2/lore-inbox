Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVGLCjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVGLCjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGLCjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:39:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12974 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261841AbVGLCiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:38:00 -0400
Date: Tue, 12 Jul 2005 03:37:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Heinz <thomasheinz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI DVD-RAM partitions
Message-ID: <20050712023757.GG26128@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Heinz <thomasheinz@gmx.net>, linux-kernel@vger.kernel.org
References: <42CFC3EF.2090804@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CFC3EF.2090804@gmx.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 02:32:47PM +0200, Thomas Heinz wrote:
> Is it possible to make the DVD-RAM partitions available as device
> nodes (or at least directly mountable without the losetup hack)?
> One solution would be to make the device available as /dev/sdX and
> /dev/srX. Is that possible?

While adding support for partitions on sr is trivial it has a huge
drawback: it's chaning the dev_t space by using up device numbers
for partitions, so /dev/sr0 ff will have different device numbers
with that change applied.  I have an old patch that's supposed to
enable support for partitioned scsi removable devices at
http://rechner.lst.de/~hch/hacks/sr-parts.diff, I'm not sure it
actually ever worked (but you should get the basic idea from it)

