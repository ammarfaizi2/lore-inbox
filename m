Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWEXDbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWEXDbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 23:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWEXDbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 23:31:14 -0400
Received: from smtp.enter.net ([216.193.128.24]:51972 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932546AbWEXDbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 23:31:13 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 23:31:03 +0000
User-Agent: KMail/1.8.1
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jeff@garzik.org>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <ADF9B4F7-2B6E-41B7-8B83-26261EBE27F7@mac.com> <1148403226.25255.89.camel@localhost.localdomain>
In-Reply-To: <1148403226.25255.89.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605232331.04674.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 16:53, Alan Cox wrote:
> On Maw, 2006-05-23 at 11:41 -0400, Kyle Moffett wrote:
> > So a modern GPU is essentially a proprietary CPU with an obscure
> > instruction set and lots of specialized texel hardware?  Given the
> > total lack of documentation from either ATI or NVidia about such
> > cards I'd guess it's impossible for Linux to provide any kind of
> > reasonable 3d engine for that kind of environment, and it might be
> > better to target a design like the Open Graphics Project is working
> > to provide.
>
> Its typically a device you feed a series of fairly low level rendering
> commands to sometimes including instructions (eg shaders). DRI provides
> an interface that is chip dependant but typically looks like
>
>
>       [User provided command buffer]
>
>       [Kernel filtering/DMA interface]
>
>       [Card command queue processing]
>
>
> All the higher level graphic work is done in the 3D client itself.

Exactly! Alans above explanation is exactly why I proposed merging DRM with 
the framebuffer drivers. However, a day later and some new information 
received, it would be better to change the framebuffer system to use DRM as a 
backend where it's possible.

DRH
