Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVALWzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVALWzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVALWzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:55:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:60651 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261527AbVALWwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:52:41 -0500
Date: Wed, 12 Jan 2005 14:16:33 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: debugfs directory structure
Message-ID: <20050112221632.GA14230@kroah.com>
References: <52d5watlqs.fsf@topspin.com> <20050112210945.GN24518@redhat.com> <20050112214108.GA13801@kroah.com> <20050112220142.GO24518@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112220142.GO24518@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 05:01:43PM -0500, Dave Jones wrote:
> On Wed, Jan 12, 2005 at 01:41:08PM -0800, Greg KH wrote:
>  > On Wed, Jan 12, 2005 at 04:09:45PM -0500, Dave Jones wrote:
>  > > On Wed, Jan 12, 2005 at 12:50:51PM -0800, Roland Dreier wrote:
>  > >  > Hi Greg,
>  > >  > 
>  > >  > Now that debugfs is merged into Linus's tree, I'm looking at using it
>  > >  > to replace the IPoIB debugging pseudo-filesystem (ipoib_debugfs).  Is
>  > >  > there any guidance on what the structure of debugfs should look like?
>  > >  > Right now I'm planning on putting all the debug info files under an
>  > >  > ipoib/ top level directory.  Does that sound reasonable?
>  > > 
>  > > How about mirroring the toplevel kernel source structure ?
>  > > 
>  > > Ie, you'd make drivers/infiniband/ulp/ipoib ?
>  > 
>  > But who would be in charge of createing the "drivers/" subdirectory?
>  > debugfs can't handle "/" in a directory name, like procfs does.
> 
> maybe it should ?

Right now debugfs is dentry based, not string based.  If someone wants
to send me patches to change it, I'll reconsider it :)

>  > > It could get ugly quickly without some structure at least to
>  > > the toplevel dir.
>  > I say ipoib/ is fine, remember, this is for debugging stuff, it will
>  > quickly get ugly anyway :)
> 
> with no heirarchy, what happens when two drivers want to make
> the same directory / filenames ?

The second call will fail.  Code should always check return values,
right?

thanks,

greg k-h
