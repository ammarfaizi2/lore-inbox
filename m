Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUIOVxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUIOVxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUIOVtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:49:40 -0400
Received: from [66.35.79.110] ([66.35.79.110]:48837 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267620AbUIOVt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:49:26 -0400
Date: Wed, 15 Sep 2004 14:49:19 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@novell.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915214919.GC22361@hockin.org>
References: <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com> <1095284330.3508.11.camel@localhost.localdomain> <1095284369.23385.125.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095284369.23385.125.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 05:39:29PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 23:38 +0200, Kay Sievers wrote:
> 
> > Anyone can watch the refcount on the fs-modules, they increment on every
> > device claim. Is that a leak in your eyes too :)
> 
> Haha, Kay, rocking point.

Not if I don't build my fs as a module?  And yeah, in the strictest sense
it IS a leak if a user can do that.

Now, I'm not *really* concerned withs ecurity, I just want to make sure we
don't flippantly disregard it.

I'd be happy if the actual block device was not part of the event.

What worries me more is that only some mount/umount calls get events, and
not all of them.
