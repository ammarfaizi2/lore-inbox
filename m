Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUHEI0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUHEI0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUHEI0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:26:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:63458 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267595AbUHEI0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:26:08 -0400
Date: Thu, 5 Aug 2004 01:24:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: wli@holomorphy.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break out zone free list initialization
Message-Id: <20040805012424.7da14c83.akpm@osdl.org>
In-Reply-To: <1091034585.2871.142.camel@nighthawk>
References: <1091034585.2871.142.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> The following patch removes the individual free area initialization from
>  free_area_init_core(), and puts it in a new function
>  zone_init_free_lists().  It also creates pages_to_bitmap_size(), which
>  is then used in zone_init_free_lists() as well as several times in my
>  free area bitmap resizing patch.  

This causes my very ordinary p4 testbox to crash very early in boot.  It's
quite pretty, with nice colourful stripes of blinking text on the display.

