Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263505AbVCEEea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbVCEEea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbVCDXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:41:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:44194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263277AbVCDVv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:51:27 -0500
Date: Fri, 4 Mar 2005 13:51:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-Id: <20050304135113.68c50e13.akpm@osdl.org>
In-Reply-To: <4228D43E.1040903@pobox.com>
References: <20050304175302.GA29289@kroah.com>
	<20050304124431.676fd7cf.akpm@osdl.org>
	<4228D43E.1040903@pobox.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > cramfs-small-stat2-fix.patch
> > setup_per_zone_lowmem_reserve-oops-fix.patch
> > dv1394-ioctl-retval-fix.patch
> > ppc32-compilation-fixes-for-ebony-luan-and-ocotea.patch
> > nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
> > nfsd--exportfs-reduce-stack-usage.patch
> 
> Unless it's crashing for people, stack usage is IMO a wanted-fix not 
> needed-fix.

Sure.  The patch is bog-obvious though.

> 
> > nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
> 
> is this critical?

Doubt it, unless the succeeding patches have a dependency on it.  But the
other patches have not been tested without this one being present.


These patches have been in mm for four weeks, so it's probably OK from a
stability POV to take them straight into linux-release.  If they were
fresher then the way to handle them would be to merge them into Linus's
tree and backport in a couple of weeks time.
