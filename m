Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSK2Lod>; Fri, 29 Nov 2002 06:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSK2Lod>; Fri, 29 Nov 2002 06:44:33 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37764 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267022AbSK2Loc>;
	Fri, 29 Nov 2002 06:44:32 -0500
Date: Fri, 29 Nov 2002 11:49:36 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] named struct initialiser updates
Message-ID: <20021129114935.GA20166@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200211260414.gAQ4EaJ26436@hera.kernel.org> <Pine.GSO.4.21.0211291044410.29438-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211291044410.29438-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 10:45:24AM +0100, Geert Uytterhoeven wrote:

 > > diff -Nru a/drivers/video/fbcon.c b/drivers/video/fbcon.c
 > > --- a/drivers/video/fbcon.c	Mon Nov 25 20:14:39 2002
 > > +++ b/drivers/video/fbcon.c	Mon Nov 25 20:14:39 2002
 > > @@ -230,8 +230,9 @@
 > >  
 > >  static void cursor_timer_handler(unsigned long dev_addr);
 > >  
 > > -static struct timer_list cursor_timer =
 > > -		TIMER_INITIALIZER(cursor_timer_handler, 0, 0);
 > > +static struct timer_list cursor_timer = {
 > > +    function: cursor_timer_handler
 > > +};
 > Doesn't this part reverse the timer initializer fix?

Looks like it. I'll take a look later.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
