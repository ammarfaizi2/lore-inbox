Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbTAITpp>; Thu, 9 Jan 2003 14:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbTAITpp>; Thu, 9 Jan 2003 14:45:45 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:29459 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266979AbTAITpm>; Thu, 9 Jan 2003 14:45:42 -0500
Date: Thu, 9 Jan 2003 19:54:22 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] rotation.
In-Reply-To: <1042044916.1003.144.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301091949560.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, as Geert mentioned, if you want to support rotation
> generically, then you have to do it in the fbcon level.  The driver need
> not know if the display is rotated or not.  All it needs to do is fill a
> region with color, color expand a bitmap and move blocks of data, and
> optionally 'pan' the window.  Fbcon will pass the correct (ie, oriented)
> information for the driver.

Yes. Hardware rotation shouldn't also not effect the way accel 
operatations are done. 

> This will not be too processor intensive as long as some data is
> prepared beforehand, like a rotated fontdata.

Yeap!! The only thing is we could end up with 4 times the amount of data.
 
> The main difficulty with this approach is how do you tell the console to
> rotate the display?  We cannot use fbset because the changes will not be
> visible to fbcon. 

I think it should video fbcon=rotate:90 command line for example.

> I submitted a patch before (see fbdev archives for "Console Rotation"
> thread) that rotates the console this way.  I had vga16fb, vesafb, and

I seen it and even have it still. 

