Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTAJTeS>; Fri, 10 Jan 2003 14:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbTAJTeS>; Fri, 10 Jan 2003 14:34:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:38669 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266959AbTAJTeR>; Fri, 10 Jan 2003 14:34:17 -0500
Date: Fri, 10 Jan 2003 19:42:59 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] rotation.
In-Reply-To: <1042171520.933.126.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301101940460.18287-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes. Hardware rotation shouldn't also not effect the way accel 
> > operatations are done.
>  
> The main difference is if the hardware supports rotation, fbcon will
> present it with "normal" data.  With the generic implementation, fbcon
> will present the driver with rotated data.
> 
> So we need a driver capabilities field either in fb_info or
> fb_fix_screeninfo.

We can just test if the rotation hook exist for the fbdev driver. No hook 
then use generic code in fbcon. Also we have a angle field in var so we 
can see if the user wants the data rotated.

> Not really.  We can dynamically rotate the fontdata using the default
> display->fontdata into another buffer.  I believe I have functions that
> do that in the patch I submitted.  (Sorry, I lost it when one of my
> drives crashed :-(.

I have that patch. It just has to be updated to the latest changes.

