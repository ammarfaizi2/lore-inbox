Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTBUANb>; Thu, 20 Feb 2003 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbTBUANb>; Thu, 20 Feb 2003 19:13:31 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:36165 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S267335AbTBUANa>; Thu, 20 Feb 2003 19:13:30 -0500
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
From: Antonino Daplas <adaplas@pol.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20030220182941.GK14445@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
	<20030220150201.GD13507@codemonkey.org.uk> 
	<20030220182941.GK14445@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1045787031.2051.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 08:24:17 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 02:29, Petr Vandrovec wrote:
> 
> I was for five weeks in U.S., so I did not do anything with
> matroxfb during that time. I plan to use fillrect and copyrect
> from generic code (although it means unnecessary multiply on
> generic side, and division in matroxfb, but well, if we gave
> up on reasonable speed for fbdev long ago...). But I simply
> want loadfont and putcs hooks for character painting. And if 
> fbdev maintainer does not want to give me them, well, then 
> matroxfb and fbdev are not compatible.

Petr,

I submitted the Tile Blitting patch to James some time ago, it has
tilefill, tilecopy and tileblit hooks.  These hooks should eliminate the
"multiply in fbcon, divide in driver" bottleneck.

It should result in the same behavior as you would expect in the the 2.4
API, so you can use text mode with your matroxfb driver.  These same
hooks will also help optimize drawing if we need to use fonts like
12x22.

Tony


