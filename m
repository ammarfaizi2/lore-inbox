Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVDDWwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVDDWwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVDDWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:50:05 -0400
Received: from galileo.bork.org ([134.117.69.57]:47285 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261267AbVDDWlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:41:45 -0400
Date: Mon, 4 Apr 2005 18:41:45 -0400
From: Martin Hicks <mort@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Hicks <mort@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] meminfo: add Cached underflow check
Message-ID: <20050404224145.GJ10693@localhost>
References: <20050404151105.GG10693@localhost> <20050404151049.53a30133.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404151049.53a30133.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 04, 2005 at 03:10:49PM -0700, Andrew Morton wrote:
> Martin Hicks <mort@sgi.com> wrote:
> >
> > Working on some code lately I've been getting huge values
> > for "Cached".  The cause is that get_page_cache_size() is an
> > approximate value, and for a sufficiently small returned value
> > of get_page_cache_size() the value underflows.
> 
> OK..
> 
> I think I'd prefer to do it this way - it's simpler and the original patch
> had a teeny race wrt changes in total_swapcache_pages.

Fine by me.

mh

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
