Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbUKOLeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUKOLeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUKOLeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:34:36 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:34062 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261569AbUKOLef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:34:35 -0500
Date: Mon, 15 Nov 2004 11:34:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 iSeries: don't share request queues in viocd
Message-ID: <20041115113410.GA14471@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@osdl.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20041115165357.2e738704.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115165357.2e738704.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 04:53:57PM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> This patch fixes the virtual cdrom driver to not share a single request
> queue.  Sharing the queue causes an oops if you remove the module and more
> than one cdrom exists.

Maybe you should fix that underlying bug?  Queues are supposed to be
shareable.

