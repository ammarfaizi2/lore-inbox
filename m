Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936488AbWLANur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936488AbWLANur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936498AbWLANur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:50:47 -0500
Received: from smtp.nokia.com ([131.228.20.173]:61594 "EHLO
	mgw-ext14.nokia.com") by vger.kernel.org with ESMTP id S936488AbWLANuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:50:46 -0500
Date: Fri, 1 Dec 2006 15:41:57 +0200
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Adrian Bunk <bunk@stusta.de>, David Woodhouse <dwmw2@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup() static
Message-ID: <20061201134157.GA31225@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
References: <20061125191541.GH3702@stusta.de> <1164752386.14595.24.camel@pmac.infradead.org> <20061125191541.GH3702@stusta.de> <20061130184556.GA23293@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130184556.GA23293@hexapodia.org>
X-Operating-System: GNU/Linux angel.research.nokia.com
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 01 Dec 2006 13:42:39.0064 (UTC) FILETIME=[912D3580:01C7154E]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our bootloader once used mtdpart_setup() for passing mtd partitions to 
kernel. We do not do that any more and instead use the kernel command line 
for passing the information.

Jarkko Lavinen

On Thu, Nov 30, 2006 at 10:45:56AM -0800, ext Andy Isaacson wrote:
> On Sat, Nov 25, 2006 at 08:15:41PM +0100, Adrian Bunk wrote:
> > This patch makes the needlessly global mtdpart_setup() static.
> > 
> > @@ -346,7 +346,7 @@
> >   *
> >   * This function needs to be visible for bootloaders.
> >   */
> > -int mtdpart_setup(char *s)
> > +static int mtdpart_setup(char *s)
> >  {
> >  	cmdline = s;
> >  	return 1;
> 
> Jarkko,
> 
> You're recorded as submitting the original patch to make this
> non-static:
> http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/mtd/cmdlinepart.c@1.11?nav=index.html|src/|src/drivers|src/drivers/mtd|hist/drivers/mtd/cmdlinepart.c
> 
> Is this change correct?
> 
> If so, it should also delete the "needs to be visible" comment.
> 
> -andy
