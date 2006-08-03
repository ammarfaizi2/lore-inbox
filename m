Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWHCHRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWHCHRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHCHRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:17:39 -0400
Received: from mail.suse.de ([195.135.220.2]:12683 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932346AbWHCHRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:17:38 -0400
Date: Thu, 3 Aug 2006 00:13:08 -0700
From: Greg KH <greg@kroah.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, stable@kernel.org, akpm@osdl.org
Subject: Re: [stable] [PATCH] ext3 -nobh option causes oops (2.6.17.7)
Message-ID: <20060803071308.GH26354@kroah.com>
References: <1154032961.29920.17.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154032961.29920.17.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:42:41PM -0700, Badari Pulavarty wrote:
> Hi Andrew,
> 
> ext3 -nobh option causes kernel oops on files other than IFREG -
> since the modification to them are journalled anyway and the
> code expects to have buffer_head attached to it.
> 
> We need this patch for stable series also.
> 
> Thanks,
> Badari
> 
> For files other than IFREG, nobh option doesn't make sense.
> Modifications to them are journalled and needs buffer heads
> to do that. Without this patch, we get kernel oops in page_buffers().
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Queued to -stable.

thanks,

greg k-h

