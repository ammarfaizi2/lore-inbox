Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUENSsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUENSsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUENSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:48:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:65248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262106AbUENSsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:48:06 -0400
Date: Fri, 14 May 2004 11:46:59 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
Message-ID: <20040514184659.GA2401@kroah.com>
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx> <20040514183450.GA2345@kroah.com> <20040514193913.A27388@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514193913.A27388@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 07:39:13PM +0100, Christoph Hellwig wrote:
> On Fri, May 14, 2004 at 11:34:50AM -0700, Greg KH wrote:
> > Do your md raid devices show up in /sys/block?  If so, then udev should
> > support them.  If not, then udev will not.
> 
> md has the chicken-egg problem of having to issue an ioctl on the md device
> to register a gendisk. 

Ick.

How did this work with devfs then?  The device node would not be present
before the ioctl needed to be called, right?  Or did it do the "magic
lookup" mess and just "know" about md devices?

thanks,

greg k-h
