Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUDNVtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUDNVtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:49:36 -0400
Received: from waste.org ([209.173.204.2]:45441 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261879AbUDNVtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:49:33 -0400
Date: Wed, 14 Apr 2004 16:49:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-ID: <20040414214900.GI1175@waste.org>
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com> <20040414011653.22c690d9.akpm@osdl.org> <407CFFF9.5010500@pobox.com> <20040414212539.GE1175@waste.org> <20040414213336.GC30663@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414213336.GC30663@havoc.gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 05:33:36PM -0400, Jeff Garzik wrote:
> On Wed, Apr 14, 2004 at 04:25:39PM -0500, Matt Mackall wrote:
> > Sticking this in arch/*/Kconfig seems silly (as does much of the
> > duplication in said files). Can we stick this and other debug bits
> > under the kallsyms option in init/Kconfig instead? Or alternately move
> > debugging bits into their own file that gets included as appropriate.
> 
> I would rather have an arch/generic/Kconfig.debug file that gets
> included.  init/Kconfig may be generic, but its name hardly implies its
> purpose as used.

Yes, and it's rather a dumping ground too.

> There are clearly two classes of debug options, one arch-specific, and
> one not.

There is a third class of options that aren't intrinsically
arch-specific, but are currently implemented on only a subset of
architectures (eg kgdb), that I would argue properly belong in the
generic debug section.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
