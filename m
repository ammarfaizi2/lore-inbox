Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbULOXWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbULOXWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbULOXWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:22:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:3753 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262528AbULOXWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:22:03 -0500
Date: Wed, 15 Dec 2004 15:19:24 -0800
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215231924.GC15867@kroah.com>
References: <20041215175805.GA9207@kroah.com> <Pine.LNX.4.44.0412151830270.3267-100000@localhost.localdomain> <21d7e9970412151433443c746b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970412151433443c746b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 09:33:46AM +1100, Dave Airlie wrote:
> > > > Which would suggest some kind of refcounting bug in drivers/char/drm/,
> > > > such that the reserved pages get unreserved and freed before their
> > > > last unmap.  I've started looking for that, but drivers/char/drm/ is
> > > > unfamiliar territory to me, so I'd be glad for someone to beat me to it.
> > ...
> 
> What's the chip? 

lspci gives me:
	ATI Technologies Inc Radeon Mobility M6 LY

> Radeon IGP by any chance, as these are shared memory
> chips I wonder have we missed something in the drm...

> also what X release....

My /var/log/Xorg.0.log says:

X Window System Version 6.8.0
Release Date: 8 September 2004
X Protocol Version 11, Revision 0, Release 6.8
Build Operating System: Linux 2.6.10-rc2 i686 [ELF] 
Current Operating System: Linux echidna 2.6.10-rc3-bk8 #213 Wed Dec 15 09:28:14 PST 2004 i686
Build Date: 17 November 2004

thanks,

greg k-h
