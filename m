Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJ2VIX>; Tue, 29 Oct 2002 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJ2VIX>; Tue, 29 Oct 2002 16:08:23 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:64250 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262112AbSJ2VIW>; Tue, 29 Oct 2002 16:08:22 -0500
Date: Tue, 29 Oct 2002 14:07:53 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK updates] fbdev changes updates.
In-Reply-To: <20021029200838.GA27552@suse.de>
Message-ID: <Pine.LNX.4.33.0210291404390.1363-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
>  > The reason for this is we will see in the future embedded ix86
>  > boards with things like i810 framebuffers with NO vga core. In this case
>  > we will need a fbdev driver for a graphical console. Thus the agp code
>  > must be started before the fbdev layer.
>
> Can you explain exactly what the agpgart code is doing that needs
> to be done earlier than framebuffer ? I don't see any reason for this
> change. There should be no GART mappings until we've booted userspace
> (except for the case of IOMMU)

The reason I did this was to prevent adding another chuck of agp code. The
current work around for AGP fbdev drivers to have there OWN AGP code. So
we can leave the agp drivers where they are at or the framebuffer layer
can have its own AGP code for itself. Which way do you think it should be
done?

1) Fbdev layer has it own AGP layer

2) Use already existing AGP layer code.


