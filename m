Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263140AbVCDXIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbVCDXIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbVCDWQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:16:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:38308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263104AbVCDU7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:59:00 -0500
Date: Fri, 4 Mar 2005 12:58:43 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050304205842.GA32232@kroah.com>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304124431.676fd7cf.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:44:31PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > A few of us $suckers will be trying to maintain a 2.6.x.y set of
> >  	releases that happen after 2.6.x is released.
> 
> Just to test things out a bit...
> 
> Here's the list of things which we might choose to put into 2.6.11.2.  I was
> planning on sending them in for 2.6.12 when that was going to be
> errata-only.

Ok, care to forward them on?

> From 2.6.11-mm1:
> 
> cramfs-small-stat2-fix.patch
> setup_per_zone_lowmem_reserve-oops-fix.patch
> dv1394-ioctl-retval-fix.patch
> ppc32-compilation-fixes-for-ebony-luan-and-ocotea.patch
> nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
> nfsd--exportfs-reduce-stack-usage.patch
> nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
> nfsd--svcrpc-rename-pg_authenticate.patch
> nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
> nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
> nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
> audit-mips-fix.patch
> make-st-seekable-again.patch
> 
> wrt the nfsd patches, Neil said:
> 
> The problem they fix is that currently:
>     Client A holds a lock
>     Client B tries to get the lock and blocks
>     Client A drops the lock
>   **Client B doesn't get the lock immediately, but has to wait for a
>            timeout. (several seconds)

Hm, odds are the nfsd one doesn't fit our list of "acceptable things",
but let's see the patches...

thanks,

greg k-h
