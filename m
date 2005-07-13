Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVGMArJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVGMArJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVGMApF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:45:05 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:8155 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262512AbVGMAoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:44:21 -0400
Date: Wed, 13 Jul 2005 10:37:00 +1000
From: Nathan Scott <nathans@sgi.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: RT and XFS
Message-ID: <20050713003700.GB980@frodo>
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo> <1121215303.29331.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121215303.29331.1.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 05:41:43PM -0700, Daniel Walker wrote:
> On Wed, 2005-07-13 at 10:25 +1000, Nathan Scott wrote:
> > On Tue, Jul 12, 2005 at 04:01:32PM -0700, Daniel Walker wrote:
> > > 
> > > Is there something so odd about the XFS locking, that it can't use the
> > > rt_lock ?
> > 
> > Not that I know of - XFS does use the downgrade_write interface,
> > whose use isn't overly common in the rest of the kernel... maybe
> > that has caused some confusion, dunno.
> 
> Current RT doesn't implement downgrade_write() , but it's trivial to add
> it.

Ah, thats probably it then.

> So it calls up_read if it has a read lock ? Or up_write if it has a
> write lock? I suppose it would be broken if it didn't though.

Thats correct.

cheers.

-- 
Nathan
