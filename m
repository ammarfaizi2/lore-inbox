Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbTHWR5C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbTHWRxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:53:04 -0400
Received: from waste.org ([209.173.204.2]:21128 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264939AbTHWRuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:50:40 -0400
Date: Sat, 23 Aug 2003 12:50:36 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm3 - cp -a kills machine
Message-ID: <20030823175036.GP3958@waste.org>
References: <20030822015658.GD3958@waste.org> <Pine.LNX.4.44.0308212259000.3258-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308212259000.3258-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 10:59:46PM -0700, Linus Torvalds wrote:
> 
> On Thu, 21 Aug 2003, Matt Mackall wrote:
> > > No console message either. Repeated after taking out local APIC
> > > support, same thing.
> > 
> > Similar repeatable problems with periodic fsck on ext3 root. Appears
> > not to be ext3 or loop, perhaps something IDE-related in Linus' bk
> > tree added between mm2 and mm3.
> 
> The more you can track this down, the easier it will be for us. Willing to 
> triangulate a bit? For example, just start testing the suspicious parts of 
> the patch?

Doh, false alarm. This turned out to be overzealous marking of
initdata (about 20 bytes!) in something I was applying locally.
Apparently, -mm3 made it straddle a page boundary.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
