Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031578AbWLAQn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031578AbWLAQn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031588AbWLAQn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:43:57 -0500
Received: from colo.lackof.org ([198.49.126.79]:13196 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1031578AbWLAQn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:43:56 -0500
Date: Fri, 1 Dec 2006 09:43:54 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, matthew@wil.cx, grundler@parisc-linux.org,
       kyle@parisc-linux.org, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] parisc: "extern inline" -> "static inline" (fwd)
Message-ID: <20061201164354.GA10549@colo.lackof.org>
References: <20061201114811.GQ11084@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201114811.GQ11084@stusta.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 12:48:11PM +0100, Adrian Bunk wrote:
> "extern inline" generates a warning with -Wmissing-prototypes and I'm 
> currently working on getting the kernel cleaned up for adding this to 
> the CFLAGS since it will help us to avoid a nasty class of runtime 
> errors.


John David Anglin is the hppa/parisc gcc maintainer and has
commented on inline variants last year:
    http://lists.parisc-linux.org/pipermail/parisc-linux/2005-October/027587.html

This makes me think -Wmissing-prototypes is reporting the wrong warning.
ie there is a prototype but no function and no label.
Can you check with gcc folks to see if this is a gcc bug?

The parisc point intentionally switched to "extern inline" at one
point and unless what jda wrote is now incorrect, I'm not inclined
to change it.

> If there are places that really need a forced inline, __always_inline 
> would be the correct solution.

Yes, all the functions marked "extern inline" are expected to get
essentially the same treatment as "always_inline".

thanks,
grant
