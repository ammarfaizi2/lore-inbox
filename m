Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVF1QV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVF1QV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVF1QV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:21:29 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:53012 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262114AbVF1QVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:21:25 -0400
Date: Tue, 28 Jun 2005 09:21:25 -0700
From: Greg KH <gregkh@suse.de>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
Message-ID: <20050628162125.GA9239@suse.de>
References: <20050628112102.GA1111@lst.de> <42C16691.3090205@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C16691.3090205@shadowconnect.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 05:02:41PM +0200, Markus Lidel wrote:
> I know, but i hopefully also have a good reason to do so... First, the 
> attributes provided through these functions are for accessing the 
> firmware... The controller has a little limitation, it could only handle 
> 64 blocks, but sysfs only have 4k...
> 
> Now there are two options:
> 
> 1) when writing: read a 64k block, merge it with the 4k block and write 
> it back, when reading: read a 64k block and only return the needed 4k block.
> 
> 2) extend the sysfs attribute to allow 64k blocks
> 
> IMHO the first is not a very good solution, because for a 64k block it 
> has to be written 16 times...
> 
> Of course if someone finds a better solution i would be glad to hear 
> about it...

Use the binary file interface of sysfs, which was written exactly for
this kind of thing. :)

thanks,

greg k-h
