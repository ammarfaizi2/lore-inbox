Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSLAMa3>; Sun, 1 Dec 2002 07:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSLAMa3>; Sun, 1 Dec 2002 07:30:29 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:36108 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S261661AbSLAMa2> convert rfc822-to-8bit; Sun, 1 Dec 2002 07:30:28 -0500
Date: Sun, 1 Dec 2002 13:37:49 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <1038580372.13625.8.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212011331240.1213-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 2002, Alan Cox wrote:

> On Fri, 2002-11-29 at 13:17, Rasmus Bøg Hansen wrote:
> > I just tried turning off DMA on the server disk (this is just a low-end
> > IDE-system): No errors in files (compressing the file thrice).
> >
> > So it does not at all seem to be a NFS-issue!
> >
> > I have no idea what is wrong. If the disk, cable or IDE controller does
> > bit-flipping when DMA is turned on, why is the problem only seen with
> > NFS? I have never seem corrupted files or metadata with DMA turned
> > (except once long ago, when I experimented with high-transfer-modes - I
> > haven't done that since)...
>
> More likely it changes the timings. There is at least one other
> possibility though. With some via bridges using slightly too slow DDR
> RAM at a 133MHz clock works reliably _until_ you get a mix of CPU and
> DMA traffic. It'll even pass memtest86.

I couldn't solve the problem by setting timing parameters...

However, the RTL8139-driver is now configured for PIO-mode instead of
MMIO-mode (CONFIG_8139TOO_PIO), and I don't see corruptions anymore.

Thank you all for your help!

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Life is that property, which a being will lose as a result of falling
out of a cold and mysterious cave 30 miles above ground level.
                     - HitchHikers Guide to the Galaxy, Douglas Adams
----------------------------------[ moffe at amagerkollegiet dot dk ] --

