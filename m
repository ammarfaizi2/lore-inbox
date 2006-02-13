Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWBMHcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWBMHcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBMHcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:32:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751182AbWBMHce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:32:34 -0500
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire
	major
From: Arjan van de Ven <arjan@infradead.org>
To: Jody McIntyre <scjody@modernduck.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <20060213035150.GE3072@conscoop.ottawa.on.ca>
References: <1138919238.3621.12.camel@localhost>
	 <1138920012.3621.19.camel@localhost>
	 <20060213035150.GE3072@conscoop.ottawa.on.ca>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:32:21 +0100
Message-Id: <1139815941.2997.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 22:51 -0500, Jody McIntyre wrote:
> On Thu, Feb 02, 2006 at 11:40:12PM +0100, Johannes Berg wrote:
> > This  patch implements dynamic minor number allocation below the 171
> > major allocated for ieee1394. Since on today's systems one doesn't need
> > to have fixed device numbers any more we could just use any, but it's
> > probably still useful to use the ieee1394 major number for any firewire
> > related devices (like mem1394).
> 
> I don't really like this.  There's no benefit to using the 1394 major
> number.  I'd rather see an improved alloc_chrdev_region() that does
> something like this but for the whole kernel (currently it "wastes" an
> entire major even if you only want 1 minor, and for what you're doing,
> grabbing 1 minor at a time makes the most sense.)


why bother? There's a LOT of majors nowadays (12 bits) so... what's the
problem with keeping the kernel side simple?
(it's not as if userspace needs to care about the exact numbers anyway
for almost everything)

