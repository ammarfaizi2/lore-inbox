Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTLWTWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTLWTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:22:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:53777 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262323AbTLWTW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:22:29 -0500
Date: Tue, 23 Dec 2003 19:22:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rob Love <rml@ximian.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223192226.A10239@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rob Love <rml@ximian.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com> <20031223191634.A8914@infradead.org> <1072207183.6015.19.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072207183.6015.19.camel@fur>; from rml@ximian.com on Tue, Dec 23, 2003 at 02:19:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:19:43PM -0500, Rob Love wrote:
> On Tue, 2003-12-23 at 14:16, Christoph Hellwig wrote:
> 
> > What user-modifiable attributes?
> 
> See /proc/sys/kernel/random
> 
> Junk like that should be ripped from procfs and put in sysfs
> corresponding to its device file.

Well, it's not just for /dev/random but also for all in-kernel cosumers
of random numbers, so doing this as a sysctl makes quite a lot of sense.

Whether sysctl should be mached into procfs or sysfs or rather be it's
own fs is an entirely different question.  Interface-wise the latter
would make most sense.

