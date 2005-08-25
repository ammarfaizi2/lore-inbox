Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVHYOJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVHYOJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVHYOJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:09:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37794 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965009AbVHYOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:09:47 -0400
Date: Thu, 25 Aug 2005 15:12:51 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Sam Creasey <sammy@sammy.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Paul Jackson <pj@sgi.com>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050825141251.GS9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.62.0508251125030.28348@numbat.sonytel.be> <Pine.LNX.4.40.0508250954240.17653-100000@sun3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0508250954240.17653-100000@sun3>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 09:59:05AM -0400, Sam Creasey wrote:
 
> I have been a little out of it for a while on the sun3 stuffs, I'll admit
> (cursed day job), but I really, really intend to get recent 2.6 running
> again.  Knowing that the rest of m68k is at least compiling is a good
> start point.  Still, I'm going with Geert, and I'm not sure where the
> compile regressions would have come from (outside of the video/serial
> drivers, which don't compile in m68k CVS either).
> 
> What compile failures are you seeing?

After looking at that for a while...  It's the second hairball in there ;-)
flush_icache_range()/flush_icache_user_range() stuff, with all related
fun.  Note that mainline has flush_ichace_range() in memory.c, which is
not picked by sun3.
