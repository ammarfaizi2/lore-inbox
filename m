Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLWR6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTLWR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:58:36 -0500
Received: from peabody.ximian.com ([141.154.95.10]:40675 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262081AbTLWR4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:56:40 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223163904.A8589@infradead.org>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur>
	 <20031223163904.A8589@infradead.org>
Content-Type: text/plain
Message-Id: <1072202194.3472.19.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 12:56:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 11:39, Christoph Hellwig wrote:

> I disagree. For fully static devices like the mem devices the udev indirection
> is completely superflous.

I see your point, so I really do not want to argue, but here is my
rationale for why everything should be done seamlessly via udev:

In a nutshell, we want a single, clean, automatic solution to device
naming.  If some "static" devices are hard coded, we introduce a special
case.  Why do that?  Why have special cases when udev can seamlessly
manage the whole thing?  Say we decide to remove /dev/foo in the kernel
- that should be reflected in udev simply by way of it no longer being
created on boot.

That is my thoughts.  I dislike special casing.  And without it, udev
can seamlessly handle everything, automatically.

But I _do_ see your point.  It is silly to generate a hotplug event for
a static device on every boot, etc. etc.  But I think the cleanliness of
not special casing certain devices in the udev solution is worth it.

	Rob Love


