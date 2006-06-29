Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWF2SaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWF2SaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWF2SaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:30:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751250AbWF2SaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:30:04 -0400
Date: Thu, 29 Jun 2006 11:29:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: pbadari@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: 2.6.17-git14 compile failure & fix
Message-Id: <20060629112952.c7231034.akpm@osdl.org>
In-Reply-To: <20060629172016.GA23736@suse.de>
References: <44A40874.20202@us.ibm.com>
	<20060629172016.GA23736@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 10:20:16 -0700
Greg KH <gregkh@suse.de> wrote:

> 
> On Thu, Jun 29, 2006 at 10:05:56AM -0700, Badari Pulavarty wrote:
> > Hi,
> > 
> > I get "unknown definition" compile failure while compiling 2.6.17-git14
> > with CONFIG_MEMORY_HOTPLUG. (kernel/resource.c line: 243) -
> > due to recent changes to it.
> > 
> > Here is the patch to fix it. I can't take credit for the patch, since its
> > part of GregKH resource_t  patches :)
> 
> Ick, yeah, that's a fix,

Oh crap, sorry, patch skew.  That never turned up in my cross-compiling :(

(It's *really hard* to turn on CONFIG_MEMORY_HOTPLUG.  Even ia64
allmodconfig won't do it).

> but the "real" fix would be for Linus to pull
> from my PCI tree which has all of the resource changes in it already
> (I sent a request to do so a few days ago...)
> 
> Linus, here's the summary again below if you want to pull.  When you
> merge, there might be some conflicts you have to handle, but hey, you
> can test out your new git merge code :)

Yes, please let's get this in.
