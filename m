Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267830AbUHERoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267830AbUHERoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHERoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:44:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17904 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267830AbUHERoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:44:03 -0400
Subject: Re: [PATCH] break out zone free list initialization
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040805012424.7da14c83.akpm@osdl.org>
References: <1091034585.2871.142.camel@nighthawk>
	 <20040805012424.7da14c83.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1091727817.27397.8123.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 10:43:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 01:24, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > The following patch removes the individual free area initialization from
> >  free_area_init_core(), and puts it in a new function
> >  zone_init_free_lists().  It also creates pages_to_bitmap_size(), which
> >  is then used in zone_init_free_lists() as well as several times in my
> >  free area bitmap resizing patch.  
> 
> This causes my very ordinary p4 testbox to crash very early in boot.  It's
> quite pretty, with nice colourful stripes of blinking text on the display.

Just for a sanity check: are there other machines that it booted on
without any problems for you?

I'll go steal someone's P4 desktop and retest.

-- Dave

