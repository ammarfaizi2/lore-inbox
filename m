Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbULTJqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbULTJqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULTJqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:46:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1773 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261468AbULTJpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:45:15 -0500
Date: Mon, 20 Dec 2004 10:45:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: /sys/block vs. /sys/class/block
Message-ID: <20041220094506.GM3140@suse.de>
References: <1103526532.5320.33.camel@gaston> <41C68A6D.6060801@yahoo.com.au> <1103534958.14050.13.camel@gaston> <41C69EF3.6010207@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C69EF3.6010207@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20 2004, Nick Piggin wrote:
> Benjamin Herrenschmidt wrote:
> >>Seems like that's where it belongs.
> >>
> >>The reason why it is in /sys/block is because it is apparently a 
> >>"subsystem",
> >>and using decl_subsys - drivers/block/genhd.c
> >
> >
> >I'm not convinced ... If you look at how /sys is organized, it really
> >doesn't make any sense ... block devives are really devices of "class
> >block", wether we have a block "subsystem" in there is irrelevant imho.
> >
> 
> Sorry to be unclear: I was agreeing with you ;)
> 
> I was just pointing out that the reason it is currently /sys/block is
> that decl_subsys call.

Ditto, the question is how to move it with as little pain as possible...
I think the symlink approach would be fine.

-- 
Jens Axboe

