Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTDJVB3 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTDJVB3 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:01:29 -0400
Received: from adsl-92-226.38-151.net24.it ([151.38.226.92]:11525 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264174AbTDJVB1 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:01:27 -0400
Date: Thu, 10 Apr 2003 23:13:03 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New radeonfb fork
Message-ID: <20030410211302.GA720@renditai.milesteg.arr>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1049642954.550.41.camel@zion.wanadoo.fr> <20030410084650.GA728@renditai.milesteg.arr> <1049984776.555.90.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049984776.555.90.camel@zion.wanadoo.fr>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21-pre7
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 04:26:16PM +0200, Benjamin Herrenschmidt wrote:
> > I couldn't find a way to set the resolution at boot time (I use the
> > driver compiled in), I tried the following, all being ignored:
> > radeonfb:1024x768-8@60
> > radeon:1024x768-8@60
> 
> Make sure you used "video=", that is you should have on your kernel
> command line video=radeon:1024x768-8@60

That made it work 8) thanks.
But there is something curious, with video=radeon:1024x768-8@60 I get:

renditai:~# fbset

mode "1024x768-60"
    # D: 65.003 MHz, H: 48.365 kHz, V: 60.006 Hz
    geometry 1024 768 1024 768 8
    timings 15384 168 8 29 3 144 6
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode
					
But with fbset "1024x768-60" I get:

renditai:~# fbset

mode "1024x768-60"
    # D: 64.998 MHz, H: 48.362 kHz, V: 60.002 Hz
    geometry 1024 768 1024 768 8
    timings 15385 160 24 29 3 136 6
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

There's very little difference, but I was expecting to get the same
mode. I'll go read how that modedb stuff works...

Thanks again, bye.

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

