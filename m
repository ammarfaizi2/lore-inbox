Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWHQNFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWHQNFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQNFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:05:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61575 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932439AbWHQNFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:05:01 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Arjan van de Ven <arjan@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155818250.11312.181.camel@localhost.localdomain>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
	 <1155797833.11312.160.camel@localhost.localdomain>
	 <1155804060.15195.30.camel@localhost.localdomain>
	 <1155806676.11312.175.camel@localhost.localdomain>
	 <20060817120013.GC6843@kroah.com>
	 <1155816777.11312.177.camel@localhost.localdomain>
	 <20060817122244.GA17956@kroah.com>
	 <1155818250.11312.181.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 15:04:21 +0200
Message-Id: <1155819861.4494.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 14:37 +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2006-08-17 at 05:22 -0700, Greg KH wrote:
> > On Thu, Aug 17, 2006 at 02:12:57PM +0200, Benjamin Herrenschmidt wrote:
> > > On Thu, 2006-08-17 at 05:00 -0700, Greg KH wrote:
> > > > On Thu, Aug 17, 2006 at 11:24:35AM +0200, Benjamin Herrenschmidt wrote:
> > > > > Probe ordering is fragile and completely defeated with busses that are
> > > > > already probed asynchronously (like USB or firewire), and things can
> > > > > only get worse. Thus we need to look for generic solutions, the trick of
> > > > > maintaining probe ordering will work around problems today but we'll
> > > > > still hit the wall in an increasing number of cases in the future.
> > > > 
> > > > That's exactly why udev was created :)
> > > > 
> > > > It can handle bus ordering issues already today just fine, and distros
> > > > use it this way in shipping, "enterprise ready" products.
> > > 
> > > Only up to a certain point and for certain drivers... but yeah. 
> > 
> > What drivers are not supported by this?  Seriously, have we missed any?
> 
> udev will not create stable names for a bunch of things... at least not
> with the default config that comes with distros. On my shuttle with the
> built-in USB card reader, whatever config comes up with the box will
> cause the machine to boot or fail to boot due to sda not beeing what
> it's expected to be, and udev is of no help because it won't create
> stable device names. 

that's what mount by label is for though..

(which isn't a udev but a distro thing)

