Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268030AbTBRVrc>; Tue, 18 Feb 2003 16:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268034AbTBRVrc>; Tue, 18 Feb 2003 16:47:32 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:60762 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S268030AbTBRVrb>; Tue, 18 Feb 2003 16:47:31 -0500
Subject: Re: [Linux-fbdev-devel] Re: New logo code [CONFIG OPTIONS]
From: Antonino Daplas <adaplas@pol.net>
To: John Bradford <john@grabjohn.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, schottelius@wdt.de,
       thoffman@arnor.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302171932.h1HJWuiY011149@darkstar.example.net>
References: <200302171932.h1HJWuiY011149@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1045605436.1233.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 05:58:04 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 03:32, John Bradford wrote:
> > So how about making the logo "float" above/obscure the text (ie,
> > overlay)?  It's not difficult to implement since fbcon.c has "redraw"
> > versions of fbcon_bmove() and fbcon_clear().  All that needs to be done
> > is do a "scissors" test before an fb_imageblit().  
> 
> On the subject of the new logo code, would it be worth making it do
> something, (change colour, move, or animate), during a console bell?
> 

Possibly, it depends on the console/input developers if they want to add
something like fb_flash_logo() besides doing a kd_mksound(). Also, if
you don't mind compiling in a bunch of logo images to your kernel.

On a more practical note, the "scissors test" (I should have named this
"exclusive clipping test") can perhaps be enabled arbitrarily by
userland clients.  You'll be left with a rectangular screen space that
will not be touched by the console.  Then a distributor can do whatever
it wants with that screen estate, say an animating splash or a pop-up
window, which in theory can be triggered any time.

Tony


