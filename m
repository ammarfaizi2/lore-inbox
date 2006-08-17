Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWHQOoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWHQOoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWHQOoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:44:25 -0400
Received: from natblert.rzone.de ([81.169.145.181]:26050 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S965062AbWHQOoX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:44:23 -0400
Date: Thu, 17 Aug 2006 16:43:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Greg KH <greg@kroah.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Multiprobe sanitizer
Message-ID: <20060817144329.GA20790@aepfle.de>
References: <1155746538.24077.371.camel@localhost.localdomain> <20060816222633.GA6829@kroah.com> <1155774994.15195.12.camel@localhost.localdomain> <1155797833.11312.160.camel@localhost.localdomain> <1155804060.15195.30.camel@localhost.localdomain> <1155806676.11312.175.camel@localhost.localdomain> <20060817120013.GC6843@kroah.com> <1155816777.11312.177.camel@localhost.localdomain> <20060817122244.GA17956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060817122244.GA17956@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 05:22:44AM -0700, Greg KH wrote:
> On Thu, Aug 17, 2006 at 02:12:57PM +0200, Benjamin Herrenschmidt wrote:
> > On Thu, 2006-08-17 at 05:00 -0700, Greg KH wrote:
> > > On Thu, Aug 17, 2006 at 11:24:35AM +0200, Benjamin Herrenschmidt wrote:
> > > > Probe ordering is fragile and completely defeated with busses that are
> > > > already probed asynchronously (like USB or firewire), and things can
> > > > only get worse. Thus we need to look for generic solutions, the trick of
> > > > maintaining probe ordering will work around problems today but we'll
> > > > still hit the wall in an increasing number of cases in the future.
> > > 
> > > That's exactly why udev was created :)
> > > 
> > > It can handle bus ordering issues already today just fine, and distros
> > > use it this way in shipping, "enterprise ready" products.
> > 
> > Only up to a certain point and for certain drivers... but yeah. 
> 
> What drivers are not supported by this?  Seriously, have we missed any?

Do serial drivers have a device symlink now, and video drivers?
