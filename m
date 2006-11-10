Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424452AbWKJWVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424452AbWKJWVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424454AbWKJWVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:21:06 -0500
Received: from zeus.pimb.org ([80.68.88.21]:11537 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S1424452AbWKJWVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:21:04 -0500
Date: Fri, 10 Nov 2006 22:43:04 +0000
From: Jody Belka <lists-lkml@pimb.org>
To: Oliver Brakmann <obrakmann@gmx.net>
Cc: Jano <jano@90-mo3-3.acn.waw.pl>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Message-ID: <20061110224304.GP2808@pimb.org>
References: <d9a083460611081309r680a5420sbb6156f5d4240797@mail.gmail.com> <20061109230443.GA4759@news.teleos-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109230443.GA4759@news.teleos-web.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 12:04:43AM +0100, Oliver Brakmann wrote:
> > +device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
> > +device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
> > +device-mapper: ioctl: error adding target to table
> 
> At this point, it looks like something already grabbed hold of /dev/hdb.
> Both evms and lvm get started here, right after S25mdadm-raid.
> 
> This is just a hunch, but you might try disabling either of the two.
> Also, it might help if you'd post the output of 'fdisk -l /dev/hdb' to
> see what's on it.  The output of 'pvs' might help, too.
> 
> I have no clue why this error only shows up with the vanilla kernel and
> not with the Ubuntu one, though :-/

That i think i can help out with. The last time i took a look at the patches
ubuntu applies, one of them was the bd-claim patch. This removes the
functionality preventing multiple "owners" of a block device, thereby allowing
the use of both traditional partitions and device-mapper on the same disk,
something specifically not permitted in the vanilla kernel.


J
-- 
Jody Belka
knew (at) pimb (dot) org
