Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTE3MWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 08:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTE3MWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 08:22:09 -0400
Received: from mail.uklinux.net ([80.84.72.21]:35344 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id S263597AbTE3MWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 08:22:08 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 30 May 2003 13:43:14 +0100
To: David Hinds <dhinds@sonic.net>
Cc: linux-kernel@vger.kernel.org, Junfeng Yang <yjf@stanford.edu>
Subject: Re: [CHECKER] pcmcia user-pointer dereference
Message-ID: <20030530124313.GA952@mrrp.telinco.co.uk>
References: <E19LjBL-0000FS-00@mrrp.telinco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19LjBL-0000FS-00@mrrp.telinco.co.uk>
User-Agent: Mutt/1.3.28i
From: Mike Playle <mike@newdawn.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 01:40:27PM +0100, David Hinds wrote:
> On Thu, May 29, 2003 at 04:30:54PM -0500, Hollis Blanchard wrote:
> > 
> > That's true for pcmcia_get_mem_page. However pcmcia_map_mem_page writes 
> > into the structure it verifies. I think pcmcia_get_first/next_window 
> > could also be used to corrupt memory (*handle = win in 
> > pcmcia_get_window).
> 
> The map_mem_page ioctl can only be used by root.  The get_*_window
> ioctl's can't corrupt anything because they, like get_mem_page, only
> read the target data structures.
> 
> -- Dave

What about memory-mapped IO registers? Can this ioctl be used to cause
an unwanted read from a memory mapped device?

-- 
Mike
