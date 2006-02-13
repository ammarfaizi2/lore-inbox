Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWBMVKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWBMVKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWBMVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:10:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36836 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964871AbWBMVKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:10:23 -0500
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire
	major
From: Arjan van de Ven <arjan@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <1139832174.6388.31.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
	 <1138920012.3621.19.camel@localhost>
	 <20060213035150.GE3072@conscoop.ottawa.on.ca>
	 <1139815941.2997.9.camel@laptopd505.fenrus.org>
	 <1139832174.6388.31.camel@localhost>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 22:10:08 +0100
Message-Id: <1139865008.2904.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 13:02 +0100, Johannes Berg wrote:
> On Mon, 2006-02-13 at 08:32 +0100, Arjan van de Ven wrote:
> > > I don't really like this.  There's no benefit to using the 1394 major
> > > number.  I'd rather see an improved alloc_chrdev_region() that does
> > > something like this but for the whole kernel (currently it "wastes" an
> > > entire major even if you only want 1 minor, and for what you're doing,
> > > grabbing 1 minor at a time makes the most sense.)
> > 
> > why bother? There's a LOT of majors nowadays (12 bits) so... what's the
> > problem with keeping the kernel side simple?
> > (it's not as if userspace needs to care about the exact numbers anyway
> > for almost everything)
> 
> Uh, ok. Seems pretty weird to effectively allocate 256 device numbers
> for just a single device, but ok :)

it's not 256 it's 2^20.... but still :) 
(eg there are 20 bits to a minor, 12 to a major)

