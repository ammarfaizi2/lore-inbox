Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWGaDmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWGaDmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 23:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWGaDmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 23:42:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:20405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750786AbWGaDmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 23:42:23 -0400
Date: Sun, 30 Jul 2006 20:37:57 -0700
From: Greg KH <greg@kroah.com>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>,
       andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-ID: <20060731033757.GA13737@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org> <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com> <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 10:27:06PM -0400, Andrew James Wade wrote:
> On Sunday 30 July 2006 20:03, Greg KH wrote:
> > Something's really broken with that version of udev then, because the
> > 094 version I have running here works just fine with these symlinks.
> 
> Maybe, but some really odd things were happening in /sys with the
> patch. I could still follow the bogus symlinks. More than that
> 
> /sys/class/mem/mem$ cd ../../class
> and
> /sys/class/mem/mem$ cd ../..
> 
> _both_ ended up with a $PWD of /sys/class.

Ick, ok, the problem is that my "virtual device" patch isn't in my
"public" patch set that Andrew pulls from.  It will fix this issue up.
I'll work on cleaning it up to be used by everyone tomorrow and move it
to the tree that Andrew pulls from.  Then the next -mm release should
have this issue fixed.

If you want to verify this, please apply the patch at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/device-virtual.patch
and let me know if it solves your issue (note that the reference
counting is not completly correct in that patch, that's why I haven't
unleashed it on -mm yet.)

thanks,

greg k-h
