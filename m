Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUAIH0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 02:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbUAIH0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 02:26:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266277AbUAIH0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 02:26:06 -0500
Date: Fri, 9 Jan 2004 08:26:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] 2.6.1-rc2 ide barrier support
Message-ID: <20040109072600.GA18416@suse.de>
References: <20040107134323.GB16720@suse.de> <1073615696.784.181.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073615696.784.181.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09 2004, Benjamin Herrenschmidt wrote:
> 
> > +	char		special_buf[8];	/* private command buffer */
> 
> Why not put that in struct drive instead ? You must be a bit more
> careful on the lifetime, but it's less bloat, there are much less
> instances of struct drive than struct request :)

Hmm? It _is_ in struct drive :-). It could be put in hwgroup actually,
but I felt it was cleaner in drive (and easier to manage).

-- 
Jens Axboe

