Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTDFUYX (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTDFUYX (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:24:23 -0400
Received: from verein.lst.de ([212.34.181.86]:19218 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263073AbTDFUYV (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:24:21 -0400
Date: Sun, 6 Apr 2003 22:35:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicholas Wourms <dragon@gentoo.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
Message-ID: <20030406223552.A12196@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Nicholas Wourms <dragon@gentoo.org>, linux-kernel@vger.kernel.org
References: <20030331162634.A14319@lst.de> <3E908DF6.1050004@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E908DF6.1050004@gentoo.org>; from dragon@gentoo.org on Sun, Apr 06, 2003 at 04:28:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 04:28:38PM -0400, Nicholas Wourms wrote:
> Christoph Hellwig wrote:
> > --- 1.14/fs/libfs.c	Wed Jan  1 02:18:35 2003
> > +++ edited/fs/libfs.c	Wed Mar 26 21:32:02 2003
> > @@ -332,14 +332,3 @@
> >  	set_page_dirty(page);
> >  	return 0;
> 
> A quick grep shows that Intermezzo FS still uses kdevname if 
> you've turned on debugging (fs/intermezzo/sysctl.c).

Look at the code.  It's not compiled in, and if someone sets the
cpp macro it won't build for lots of other reasons (e.g. set_device_ro
prototype).

> As for 
> pending stuff, both Reiser4 & pktcdvd also use it.  So I 
> guess people are still using it...

That's they problem.  Bot that either of them is scheduled for 2.6
anyway as far as I know.

> What is your reason for 
> removing it?

It's a broken interface.  Use the proper replacements instead.

