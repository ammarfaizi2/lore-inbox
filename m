Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKBRvh>; Thu, 2 Nov 2000 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKBRv1>; Thu, 2 Nov 2000 12:51:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24386 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129050AbQKBRvL>; Thu, 2 Nov 2000 12:51:11 -0500
Subject: Re: so vesafb doesn't work in i815
To: narancs1@externet.hu (Narancs 1)
Date: Thu, 2 Nov 2000 17:51:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.02.10011021714550.9875-100000@prins.externet.hu> from "Narancs 1" at Nov 02, 2000 05:20:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rOWr-0001ik-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The i810 hardware only has limited support for old style linear video modes
> > so that is quite possible.
> 
> Wow! So then I just cannot use this motherboard at all!
> xfree 3.3.6 , also with the driver that can be downloaded from intel - I
> could run it only at 320x200x4.
> xfree 4.0.1d supports it, but the screen flicker so hard, that is is
> unusable. 

Ah there is a trick to that bit. If you have some i810 stuff then XFree does
funnies if you have DRM enabled. 

The following combination I know works

2.2.18pre18
XFree 4.0 rpms from Red Hat (not 100% sure which 4.0 set they match sorry)
DRM disabled in the XF86Config.

On my i810 the DRM/flicker problem isnt present but I have seen other folks with
it and disabling the direct 3d stuff cured it.

2.2.18pre18 also supports the i810 audio reasonably well. For full UDMA ide you
want 2.4test or 2.2.18pre18 + ide patch

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
