Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWBTQda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWBTQda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWBTQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:33:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:24259
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161015AbWBTQdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:33:17 -0500
Date: Mon, 20 Feb 2006 08:33:14 -0800
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-ID: <20060220163314.GA5524@suse.de>
References: <20060220042615.5af1bddc.akpm@osdl.org> <6bffcb0e0602200533p1a3da98ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0602200533p1a3da98ew@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 02:33:44PM +0100, Michal Piotrowski wrote:
> Hi,
> 
> On 20/02/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> >
> [snip]
> > +gregkh-usb-usb-initdata-fixes.patch
> > +gregkh-usb-usbfs2.patch
> >
> >  USB tree updates
> 
> I have noticed this:
> 
> drivers/built-in.o: In function
> `securityfs_create_dir':/usr/src/linux-mm/drivers/usb/usbfs2/usbfs2.c:271:
> multiple definition of `securityfs_create_dir'

Yeah, usbfs2 was a copy of securityfs, and can't be built into the
kernel just yet.  You can safely disable usbfs2 for now, as it's still a
work in progress and doesn't really work at all.

thanks,

greg k-h
