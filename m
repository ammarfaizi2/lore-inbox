Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbULHXB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbULHXB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbULHXB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:01:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59826 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261398AbULHXBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:01:23 -0500
Date: Thu, 9 Dec 2004 10:01:18 +1100
From: Greg Banks <gnb@sgi.com>
To: Steve Lord <lord@xfs.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: negative dentry_stat.nr_unused causes aggressive dcache pruning
Message-ID: <20041208230118.GC4239@sgi.com>
References: <41B77D54.4080909@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B77D54.4080909@xfs.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 04:16:52PM -0600, Steve Lord wrote:
> 
> I have seen this stat go negative (just from booting up a multi cpu box),
> and looking at the code, it is manipulated without locking in a number
> of places. I have only seen this in real life on a 2.4 kernel, but 2.6
> also looks vulnerable.

On early 2.6.x, a heavy streaming NFS load was a great way to trigger
this.  I haven't seen it happen since

http://linus.bkbits.net:8080/linux-2.5/cset@40b8cf606MV-gl6VpDyWKzzW1jaIJw

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
