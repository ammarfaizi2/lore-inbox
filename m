Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWGDVsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGDVsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGDVsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:48:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:10422 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751256AbWGDVsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:48:43 -0400
Date: Tue, 4 Jul 2006 14:45:08 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resource_size_t and printk()
Message-ID: <20060704214508.GA23607@kroah.com>
References: <44AAD59E.7010206@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AAD59E.7010206@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 10:54:54PM +0200, Pierre Ossman wrote:
> Hi there!
> 
> Your commit b60ba8343b78b182c03cf239d4342785376c1ad1 has been causing me
> a bit of confusion and I thought I'd point out the problem so that you
> can resolve it. :)
> 
> resource_size_t is not guaranteed to be a long long, but might be a u64
> or u32 depending on your .config. So you need an explicit cast in the
> printk:s or you get a lot of junk on the output.

That is exactly correct.  Is there somewhere in that patch that I forgot
to fix this up properly?

thanks,

greg k-h
