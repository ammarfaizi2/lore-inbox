Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVALVrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVALVrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALVnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:43:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:55500 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261470AbVALVlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:41:14 -0500
Date: Wed, 12 Jan 2005 13:41:08 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: debugfs directory structure
Message-ID: <20050112214108.GA13801@kroah.com>
References: <52d5watlqs.fsf@topspin.com> <20050112210945.GN24518@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112210945.GN24518@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 04:09:45PM -0500, Dave Jones wrote:
> On Wed, Jan 12, 2005 at 12:50:51PM -0800, Roland Dreier wrote:
>  > Hi Greg,
>  > 
>  > Now that debugfs is merged into Linus's tree, I'm looking at using it
>  > to replace the IPoIB debugging pseudo-filesystem (ipoib_debugfs).  Is
>  > there any guidance on what the structure of debugfs should look like?
>  > Right now I'm planning on putting all the debug info files under an
>  > ipoib/ top level directory.  Does that sound reasonable?
> 
> How about mirroring the toplevel kernel source structure ?
> 
> Ie, you'd make drivers/infiniband/ulp/ipoib ?

But who would be in charge of createing the "drivers/" subdirectory?

debugfs can't handle "/" in a directory name, like procfs does.

> It could get ugly quickly without some structure at least to
> the toplevel dir.

I say ipoib/ is fine, remember, this is for debugging stuff, it will
quickly get ugly anyway :)

thanks,

greg k-h
