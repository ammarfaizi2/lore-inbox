Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbTCSPX3>; Wed, 19 Mar 2003 10:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTCSPX3>; Wed, 19 Mar 2003 10:23:29 -0500
Received: from havoc.daloft.com ([64.213.145.173]:3262 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S263073AbTCSPX2>;
	Wed, 19 Mar 2003 10:23:28 -0500
Date: Wed, 19 Mar 2003 10:34:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>,
       usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.5.65] ehci-hcd, don't use PCI MWI
Message-ID: <20030319153421.GA26181@gtf.org>
References: <3E788B06.4090302@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E788B06.4090302@pacbell.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 07:21:42AM -0800, David Brownell wrote:
> Hi,
> 
> Some users have been sending init logs for Athlon kernels that
> include PCI warning messages about the PCI cache line size
> getting set incorrectly ... where the kernel thinks that the
> right value is 16 bytes.  Since 64 bytes is the right number,
> it's dangerous to enable MWI on such systems.
> 
> This patch stops trying to use MWI; it's a workaround for the
> misbehavior of that PCI cacheline-setting code.  Please apply
> to 2.5 and 2.4 trees.

Please don't -- Ivan has a patch for this, let's get that in instead.

We all acknowledge your patch is a workaround, but this sort of fix does
not belong in the mainstream kernel.  We want to fix it The Right
Way(tm), once.  And since a patch already exists for this...

We need to get IvanK's extended-save-restore-state patch in, too.

Ivan, would you be up for a repost on lkml?

	Jeff



