Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUGDWEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUGDWEt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUGDWEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:04:49 -0400
Received: from [213.146.154.40] ([213.146.154.40]:46548 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265809AbUGDWEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:04:46 -0400
Date: Sun, 4 Jul 2004 23:04:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.7: sk98lin unload oops
Message-ID: <20040704220446.GA9010@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernd Schubert <bernd-schubert@web.de>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200407041342.18821.bernd-schubert@web.de> <200407042028.59047.bernd-schubert@web.de> <20040704184404.GA7262@infradead.org> <200407050001.46489.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407050001.46489.bernd-schubert@web.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 12:01:35AM +0200, Bernd Schubert wrote:
> [from your other mail]
> > the previous one) makes it work unless you change the interface name
> > manually, but as Linux explicitly allows that the interface is
> > fundamentally broken and probably should just go away.
> 
> Unfortunality we rename all interfaces using ifrename to make sure that the 
> interface names won't change with different kernel versions (we have this 
> problem when we switch between 2.4. and 2.6.). So it is normal that the oops 
> occurs on unloading the modules?

Well, the problem is that someone smoked bad crack when designing the sk98lin
procfs interface ;-)  We should probably just kill it and find a better way
to export the information if nessecary.  I'll take a look at that.

> Btw, on 22th June I got another skge.c patch from Herbert Xu to fix another 
> oops:
> 
> http://lkml.org/lkml/2004/6/22/44
> 
> This patch applies fine on top of your new versions (with 400 lines offset), 
> maybe this patch should also be included into the current BK tree?

Jeff already merged that patch.
