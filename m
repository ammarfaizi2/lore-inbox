Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTJMJGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTJMJGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:06:16 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:40832
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261585AbTJMJGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:06:15 -0400
Date: Mon, 13 Oct 2003 05:05:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] No swapping on memory backed swapfiles
In-Reply-To: <20031013011117.103de5e7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0310130502440.28426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0310130354440.28426@montezuma.fsmlabs.com>
 <20031013011117.103de5e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > +	bdi = mapping->backing_dev_info;
> >  +	if (bdi->memory_backed)
> >  +		goto bad_swap;
> >  +
> 
> I guess that makes sense, although someone might want to swap onto a
> ramdisk-backed file just for some testing purpose.
> 
> Why not simply test for a null ->readpage()?

That was my initial intention, but then i wondered why someone would be 
swapping to a memory backed filesystem in the first place. Also things 
like ramfs have ->readpage().
