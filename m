Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbRBLSsg>; Mon, 12 Feb 2001 13:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130884AbRBLSs0>; Mon, 12 Feb 2001 13:48:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130864AbRBLSsR>; Mon, 12 Feb 2001 13:48:17 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: LILO and serial speeds over 9600
Date: 12 Feb 2001 10:47:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <969b4m$sbp$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10102120741290.3761-100000@main.cyclades.com> <Pine.LNX.4.10.10102120849580.3761-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10102120849580.3761-100000@main.cyclades.com>
By author:    Ivan Passos <lists@cyclades.com>
In newsgroup: linux.dev.kernel
> 
> Since I still want to add support for speeds up to 115200, the other two
> questions are still up (see below):
> 
> > - If not, do I need to change just LILO to do that, or do I need to change
> >   the kernel as well (I don't think I'd need to do that too, as the serial 
> >   console kernel code does support up to 115.2Kbps, but it doesn't hurt to 
> >   ask ... ;) ??
> > - Does another bootloader (e.g. GRUB) support serial speeds higher than
> >   9600bps?? If so, which one(s)??
> 
> I'd really appreciate any help.
> 

SYSLINUX supports up to 57600 (it doesn't support 115200 because it
stores the number in a 16-bit register) but seriously... why the heck
does this matter?  It isn't booting the kernel off the serial line,
you know.  A console at 38400 is really quite sufficient... if you
need something more than that, you probably should be logging in via
the network.

I have toyed a few times about having a simple Ethernet- or UDP-based
console protocol (TCP is too heavyweight, sorry) where a machine would
seek out a console server on the network.  Anyone has any ideas about
it?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
