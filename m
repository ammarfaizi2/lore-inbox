Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271455AbTGYCdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 22:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTGYCdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 22:33:23 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:62125 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S271455AbTGYCdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 22:33:22 -0400
From: Richard Drummond <lists@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Organization: Private
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Big-endian fixes for tdfxfb in 2.4.21
Date: Thu, 24 Jul 2003 21:53:13 -0500
User-Agent: KMail/1.5.2
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307250040290.7845-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0307250040290.7845-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307242153.14002.lists@rcdrummond.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Thursday 24 July 2003 06:41 pm, James Simmons wrote:
> > Ooops. I apologize. It turns out that I didn't test this as thoroughly as
> > I had thought. Although the Voodoo3 works perfectly, 16-bit and 32-bit
> > modes are still broken on the Voodoo4.
>
> I have a Voodoo 5 so I can give it a try this week end. I don't have docs
> on the latest cards. I will apply the patch to 2.5.X this weekend.

I have been doing some experimenting with the Voodoo4 on my Mac, and I have 
made a little progress. By doing register dumps and general snooping about to 
discover how MacOS sets up the card, I've found that the card actually 
supports a big-endian aperture on the framebuffer (this is different from how 
big-endian support works on the Voodoo3). As I don't have docs, there's a lot 
of guess-work involved, and I haven't got it working 100% reliably yet - but 
once I do I'll supply a patch.

I'm also working on getting the hwcursor working. The patch I produced against 
2.4.21 does contain fixes for the hwcursor on the Voodoo3 for big-endian 
machines. Again, though, because the different way byte-swizzling works on 
the Voodoo4/5, it doesn't work there in 16- and 32-bit modes. When I get the 
big-endian fixes for the Voodoo4/5 finished, I'll have look at the hwcursor 
on 2.5/2.6 . . . 

Cheers,
Rich

