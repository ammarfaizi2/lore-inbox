Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUD3WbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUD3WbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUD3WbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:31:14 -0400
Received: from florence.buici.com ([206.124.142.26]:58254 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261610AbUD3WbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:31:13 -0400
Date: Fri, 30 Apr 2004 15:31:12 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040430223112.GA29325@buici.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com> <409083E9.2080405@yahoo.com.au> <20040429144941.GC708@buici.com> <4091D123.9070606@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4091D123.9070606@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 02:08:03PM +1000, Nick Piggin wrote:
> You would probably be better off trying a simpler change
> first actually:
> 
> in mm/vmscan.c, shrink_list(), change:
> 
> if (res == WRITEPAGE_ACTIVATE) {
> 	ClearPageReclaim(page);
> 	goto activate_locked;
> }
> 
> to
> 
> if (res == WRITEPAGE_ACTIVATE) {
> 	ClearPageReclaim(page);
> 	goto keep_locked;
> }
> 
> I think it is not the correct solution, but should narrow
> down your problem. Let us know how it goes.

OK, thanks.  It might be a few days before I can get to this.
