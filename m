Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbSLECem>; Wed, 4 Dec 2002 21:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSLECel>; Wed, 4 Dec 2002 21:34:41 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:37508 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S267190AbSLECeh>;
	Wed, 4 Dec 2002 21:34:37 -0500
Date: Thu, 5 Dec 2002 03:41:57 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
Message-ID: <20021205024157.GA19706@vana>
References: <96665BC46B2@vcnet.vc.cvut.cz> <1039056748.1032.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039056748.1032.22.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 07:53:16AM +0500, Antonino Daplas wrote:
> On Thu, 2002-12-05 at 03:33, Petr Vandrovec wrote:
> > On  5 Dec 02 at 6:05, Antonino Daplas wrote:
> > planes 0 & 1.
> 
> Okay, then.  My approach was to be non-vgacon specific.  I'll do it to
> specifically target vgacon then.
> 
> To summarize:
> plane 0/1 save 8K at offset 0 and 8K at offset 16K;

I'm not sure about this one. AFAIK by default vgacon uses first 32KB
completely (every second byte...) from both 0/1, and can be configured
(by enabling VGA_CAN_DO_64KB) to use full 64KB.

> plane 2   save 32K at offset 0 (covers blocks 0-3),
> plane 3   same for plane 2
> 
> Drivers can set VGA_SAVE_TEXT | VGA_SAVE_FONT0 to save planes 0-2.  If
> there are no complaints, I'll  proceed doing it this way.

I have no other problems.
						Petr Vandrovec
						vandrove@vc.cvut.cz
