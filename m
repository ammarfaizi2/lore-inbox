Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264214AbRFNX4G>; Thu, 14 Jun 2001 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264216AbRFNXzq>; Thu, 14 Jun 2001 19:55:46 -0400
Received: from www.transvirtual.com ([206.14.214.140]:56080 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S264214AbRFNXzm>; Thu, 14 Jun 2001 19:55:42 -0400
Date: Thu, 14 Jun 2001 16:55:31 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "David S. Miller" <davem@redhat.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VGA handling was [Re: Going beyond 256 PCI buses]
In-Reply-To: <15145.19442.773217.177804@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10106141650490.12951-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You going to have to enable/disable I/O, MEM access, and VGA pallette
> snooping in the PCI_COMMAND register of both boards every time you go
> from rendering text on one to rendering text on the other.  If there
> are bridges leading to either device, you may need to fiddle with VGA
> forwarding during each switch as well.
> 
> You'll also need a semaphore or similar to control this "active VGA"
> state.
> 
> Really, I don't think this is all that good of an idea.

Yes I know. Also each card needs it own special functions to handle
programming the CRTC, SEQ registers etc. Perhaps for real multihead
support I guess the user will have to use fbdev. vgacon can just exist for
single head systems. I guess it is time to let vga go. It is old technology. 

