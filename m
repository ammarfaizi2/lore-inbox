Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286274AbRLTP0y>; Thu, 20 Dec 2001 10:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286275AbRLTP0p>; Thu, 20 Dec 2001 10:26:45 -0500
Received: from ns0.cobite.com ([208.222.80.10]:44558 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S286274AbRLTP0e>;
	Thu, 20 Dec 2001 10:26:34 -0500
Date: Thu, 20 Dec 2001 10:26:03 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: <david@admin>
To: Thomas Winischhofer <tw@webit.com>
cc: <linux-kernel@vger.kernel.org>, <xpert@XFree86.Org>
Subject: Re: SiS 630 - framebuffer fixed
In-Reply-To: <3C21051E.DB2FB56@webit.com>
Message-ID: <Pine.LNX.4.33.0112201019220.15155-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, Thomas Winischhofer wrote:

> 
> Hi,
> 
> after five days of struggle with reverse-engineered assembler code
> transformed to C, I could fix the SiS framebuffer driver for use with
> some LCD displays using a LVDS (Chromtel) video bridge. That is what
> most laptops use, as for example the Gericoms (and some Claveos I have
> heard).
> 
...
>  c) Always set the video memory to the maximum available. Low mem
> situations are not handled well by DRM/DRI.

I've actually been following your progress via the Xpert list archives.  
Good stuff.  I have an SiS 630 card not in a laptop, and I'll try your 
code out later.  But my question regards DRM and something mentioned on 
that list, TurboQueue...

When I use the DRM code with XFree 4.1 it usually freezes after about 30 
seconds or so (in the teapot demo - sooner with tuxracer) and I think I've 
tracked it down to the 'mWait3DCmdQueue' macro, which basically busy waits 
for a certain register value.  It just so happens that the TurboQueue code 
also happens to busy wait on this register, and it was causing hangs for 
you with just 2d code (right?).

Do you know anything about why these hangs were happening?

I'll try your code tonight (although sisfb has always worked for me!) and 
hopefully the CVS X code with DRM.  I'll let you know if it still works, 
and send you my X startup log.


David


-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

