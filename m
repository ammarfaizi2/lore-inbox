Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUAaE2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 23:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUAaE2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 23:28:23 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:5640 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S263082AbUAaE2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 23:28:21 -0500
Date: Fri, 30 Jan 2004 22:41:36 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: nVidia driver uses far less memory now, was Re: Nvidia drivers and 2.6.x kernel
Message-ID: <20040131034136.GA17945@widomaker.com>
References: <200401221004.06645.chakkerz@optusnet.com.au> <200401230942.13888.chakkerz@optusnet.com.au> <401052C6.7040500@ihateaol.co.uk> <200401261024.28998.chakkerz@optusnet.com.au> <20040127224946.GC23758@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127224946.GC23758@widomaker.com>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, 27 Jan 2004 @ 17:49 -0500, Charles Shannon Hendrix said:

> nVidia has released drivers supporting kernel 2.6 on their website.
> 
> They run nicely for me.

Followup note: Running the new nVidia drivers, I see a huge drop in the
size of the X server.

My normal X server virgual memory size was around 260MB.  If I played a
game like Infiltration, it would rise to 300MB.  After exiting the game,
the virtual size stayed where it was.  It never shrunk, and it ate a lot
of swap space too.

Then I upgraded to the new nVidia drivers which support the 2.6 kernel,
and things have changed.

I noticed my system was swapping a lot less, but didn't have time to
look into it.

Today I did.

My X server now hovers around 76MB, virtual size. Loading Infiltration
causes it to grow to around 98MB.  When I exit the game, it drops back
down to 76MB virtual.

It also seems to release memory after a program like The Gimp has been
running, though I've done less testing with that.  I've observed a
110MB->78MB drop when exiting The Gimp, but didn't record the event.

Wow... I started out on 8-bit micros, and talking about "drops" of 32MB
amazes me sometimes.

Questions:

Is the new driver able to hide the graphics aperature, showing a more
true statistic on memory use?

Was the 2.6 kernel always capable of showing the right thing, and the
new driver being made for 2.6 is just working better?

Why does the virtual memory size shrink now?  Could the new driver be
unmapping vitual memory to free it up?

I'm going to ask nVidia, but wanted to post here and also see if anyone
else noticed this.

-- 
shannon "AT" widomaker.com -- ["Star Wars Moral Number 17: Teddy bears are
dangerous in herds."]
