Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUENSxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUENSxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUENSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:51:57 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:59922 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262170AbUENSvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:51:24 -0400
Date: Fri, 14 May 2004 19:51:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
Message-ID: <20040514195121.A27504@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>,
	Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
	linux-kernel@vger.kernel.org
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx> <20040514183450.GA2345@kroah.com> <20040514193913.A27388@infradead.org> <20040514184659.GA2401@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040514184659.GA2401@kroah.com>; from greg@kroah.com on Fri, May 14, 2004 at 11:46:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:46:59AM -0700, Greg KH wrote:
> How did this work with devfs then?  The device node would not be present
> before the ioctl needed to be called, right?  Or did it do the "magic
> lookup" mess and just "know" about md devices?

md uses blk_register_region to get a callback for it's dev_t region without
a registered gendisk, and also creates devfs entries before the gendisk
is registered.  It's a single big mess.

