Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWHQMPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWHQMPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWHQMPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:15:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:51136 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932206AbWHQMPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:15:10 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060817120013.GC6843@kroah.com>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
	 <1155797833.11312.160.camel@localhost.localdomain>
	 <1155804060.15195.30.camel@localhost.localdomain>
	 <1155806676.11312.175.camel@localhost.localdomain>
	 <20060817120013.GC6843@kroah.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 14:12:57 +0200
Message-Id: <1155816777.11312.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 05:00 -0700, Greg KH wrote:
> On Thu, Aug 17, 2006 at 11:24:35AM +0200, Benjamin Herrenschmidt wrote:
> > Probe ordering is fragile and completely defeated with busses that are
> > already probed asynchronously (like USB or firewire), and things can
> > only get worse. Thus we need to look for generic solutions, the trick of
> > maintaining probe ordering will work around problems today but we'll
> > still hit the wall in an increasing number of cases in the future.
> 
> That's exactly why udev was created :)
> 
> It can handle bus ordering issues already today just fine, and distros
> use it this way in shipping, "enterprise ready" products.

Only up to a certain point and for certain drivers... but yeah. That's
probably the right direction to take. Now, I'll let you and Alan argue
wether it's sufficient or not to move toward a fully parallel probing :)

Ben.


