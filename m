Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934265AbWKTQnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934265AbWKTQnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934267AbWKTQnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:43:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24284 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S934265AbWKTQnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:43:05 -0500
Date: Mon, 20 Nov 2006 16:42:58 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
 <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 11/17/06, James Simmons <jsimmons@infradead.org> wrote:
> > 
> > Are those actually numbers? If they are the problem isn't byte reversal
> > but bit shifting.
> > 
> > 1010100 = 54
> > 0101010 = 2A
> 
> It's not byte reversal, but _bits_ of each bytes have been inversed
> (bit7->bit0, bit6->bit1, bit5->bit2, bit4->bit3, bit3->bit4, ...)
> after calling slow_imageblit(). Is it something expected ?

Yipes!! Bit reversal. I have never seen that before. Is only the logo
messed up? Slow_imageblit can be called if there is no dword alignment 
for the font bitmaps. So the question is do most if not all our fonts 
look okay?
 
> > I really don't understand why fbmem.c has its own routines to handle the
> > logo for the color > map. I can set creating a fbcmap and calling
> > fb_set_cmap instead.
> 
> Unfortunately I cannot help you on this point...
> 
> > That will be a  separte patch.
> > 
> 
> Thanks
> 
