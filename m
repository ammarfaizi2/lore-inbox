Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWGKOFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWGKOFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGKOFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:05:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8607 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750807AbWGKOFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:05:17 -0400
Date: Tue, 11 Jul 2006 09:04:52 -0500
From: Dean Nelson <dcn@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL} {,un}register_die_notifier
Message-ID: <20060711140452.GA19238@sgi.com>
References: <20060630113317.GV19712@stusta.de> <20060630203546.93a7bd87.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630203546.93a7bd87.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 08:35:46PM -0700, Andrew Morton wrote:
> On Fri, 30 Jun 2006 13:33:17 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > -EXPORT_SYMBOL(register_die_notifier);
> > +EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
> > -EXPORT_SYMBOL(unregister_die_notifier);
> > +EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
> 
> I'd expect there are any number of low-level debugging quick-hacky modules
> around which want to hook into here.
> 
> We can try it I guess, but I expect we'll hear about it.

The XPC module, which is in the community tree, references both symbols.
See arch/ia64/sn/kernel/xpc_main.c for details.

Dean
