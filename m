Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753866AbWKFWRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbWKFWRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbWKFWRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:17:33 -0500
Received: from mailhub.stratus.com ([134.111.1.18]:65162 "EHLO
	mailhub5.stratus.com") by vger.kernel.org with ESMTP
	id S1753866AbWKFWRd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:17:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc4-mm2
Date: Mon, 6 Nov 2006 17:17:20 -0500
Message-ID: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A04A@EXNA.corp.stratus.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc4-mm2
Thread-Index: AccB70Hl2ESiFuNES96dxcSOi4qExAAAG4Ug
From: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
To: <ajwade@alumni.uwaterloo.ca>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-fbdev-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 06 Nov 2006 22:17:20.0686 (UTC) FILETIME=[53BB04E0:01C701F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew -

Yours is PCI device id 0x5157. Mine is 0x515E - which is also dual-head-
capable, but we don't have it wired that way (it's on the motherboard).
0x1002 is ATI's PCI vendor id. Lspci is just printing out the PCI config
header in a nicer format (so that you can read it).

I think I remember something relevant from working on these chips
before:
there was some kind of a hardware bug in some of them that caused you to
have to pretend that unpacked 24-bit pixels were twice as many 16-bit
pixels. I think you had to double basically everything that dealt with 
widths or offsets into a scan line. I don't remember the details
anymore,
and I can't really ask, since that company has a proprietary Unix. I'll
try
to remember what it was - and which ones it affected, since that is
probably
what's wrong with the 24bpp. Too bad the chip specs are so crummy...
How much is each line offset when you have the garbled stuff? I mean, is
it
a couple pixels, half the total width, something else? And is it always
the
same for each line (or can you tell)?

/Charlotte



> -----Original Message-----
> From: Andrew Wade [mailto:andrew.j.wade@gmail.com]
> Sent: Monday, November 06, 2006 5:02 PM
> To: Richardson, Charlotte
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; Kimball Murray;
linux-
> fbdev-devel@lists.sourceforge.net
> Subject: Re: 2.6.19-rc4-mm2
> 
> On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com>
> wrote:
> > What's the device id of your VC1?
> 
> I presume lscpi -n -v will tell you what you need to know. I don't
know
> how to read the output myself:
> 
> 0000:01:00.0 0300: 1002:5157
>         Subsystem: 1002:013a
>         Flags: bus master, stepping, 66MHz, medium devsel, latency 64,
IRQ
> 16
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         I/O ports at d800 [size=256]
>         Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at d7fe0000 [disabled] [size=128K]
>         Capabilities: [58] AGP version 2.0
>         Capabilities: [50] Power Management version 2
> 
> My card is a dual-head card, but I'm only using one head. On that
head, if
> I switch to virtual console 1, everything is fine, but if I switch to
any
> other vitual console, the display is "garbled": each row of pixels is
> offset
> from the row before, producing interlaced "ghost" images.
> 
> I hope this helps; feel free to ask further questions.
> 
> -ajw
