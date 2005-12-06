Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVLFDfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVLFDfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVLFDfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:35:39 -0500
Received: from kanga.kvack.org ([66.96.29.28]:41603 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751575AbVLFDfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:35:38 -0500
Date: Mon, 5 Dec 2005 22:32:36 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Rob Landley <rob@landley.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206033236.GC15428@kvack.org>
References: <20051203152339.GK31395@stusta.de> <200512051647.55395.rob@landley.net> <20051205230502.GB12955@kvack.org> <200512052119.28706.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512052119.28706.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 09:19:28PM -0600, Rob Landley wrote:
> > /sbin/hotplug is suboptimal.  Even a pretty fast machine is slowed down
> > pretty significantly by the ~thousand fork and exec that take place during
> > startup.
> 
> Why do you need hotplug events on startup?  Can't you just scan /sys for "dev" 
> entries do the initial populate of /dev from that?

That's my point: I don't.  Yet the kernel tries to exec /sbin/hotplug on 
startup around 1000 times.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
