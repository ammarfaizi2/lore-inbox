Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWIUAMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWIUAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWIUAMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:12:16 -0400
Received: from xenotime.net ([66.160.160.81]:34194 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750810AbWIUAMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:12:16 -0400
Date: Wed, 20 Sep 2006 17:13:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reiner Herrmann <reiner@reiner-h.de>
Cc: adaplas@pol.net, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation fixes in intel810.txt
Message-Id: <20060920171319.adb5fc5a.rdunlap@xenotime.net>
In-Reply-To: <200609210132.54818.reiner@reiner-h.de>
References: <200609210103.10768.reiner@reiner-h.de>
	<20060920161546.7d009c9e.rdunlap@xenotime.net>
	<200609210132.54818.reiner@reiner-h.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 01:32:54 +0200 Reiner Herrmann wrote:

> > >  
> > > -   g. "hsync1/hsync2:<value>" 
> > > -	select the minimum and maximum Horizontal Sync Frequency of the 
> > > -	monitor in KHz.  If a using a fixed frequency monitor, hsync1 must 
> > > +   g. "hsync1/hsync2:<value>"
> > > +	select the minimum and maximum Horizontal Sync Frequency of the
> > > +	monitor in kHz.  If using a fixed frequency monitor, hsync1 must
> > 
> > Why small 'k'?  Is that some standard?
> > I prefer KHz but I'm flexible.
> 
> Those prefixes are case-sensitive (i.e. m = milli and M = Mega).
> The abbreviation for kilo is a lowercase k.

Yep, unfortunately.  so there goes history.  oh well.  :)

> So here is a corrected version of the patch (with some more fixes I just detected).

one small comment below.

> Signed-off-by: Reiner Herrmann <reiner@reiner-h.de>
> ---
> diff -uprN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18/Documentation/fb/intel810.txt linux-work/Documentation/fb/intel810.txt
> --- linux-2.6.18/Documentation/fb/intel810.txt	2006-09-20 05:42:06.000000000 +0200
> +++ linux-work/Documentation/fb/intel810.txt	2006-09-21 01:30:37.000000000 +0200

> -   i. "voffset:<value>"	
> -        select at what offset in MB of the logical memory to allocate the 
> +   i. "voffset:<value>"
> +	select at what offset in MB of the logical memory to allocate the
>  	framebuffer memory.  The intent is to avoid the memory blocks
>  	used by standard graphics applications (XFree86).  The default
> -        offset (16 MB for a 64MB aperture, 8 MB for a 32MB aperture) will
> -        avoid XFree86's usage and allows up to 7MB/15MB of framebuffer
> -        memory.  Depending on your usage, adjust the value up or down, 
> -	(0 for maximum usage, 31/63 MB for the least amount).  Note, an 
> +	offset (16 MB for a 64MB aperture, 8 MB for a 32MB aperture) will

You could make "<number> MB" be consistent (preferably with space there).
Otherwise looks good to me.  Thanks.

> +	avoid XFree86's usage and allows up to 7MB/15MB of framebuffer
> +	memory.  Depending on your usage, adjust the value up or down,
> +	(0 for maximum usage, 31/63 MB for the least amount).  Note, an
>  	arbitrary setting may conflict with XFree86.

---
~Randy
