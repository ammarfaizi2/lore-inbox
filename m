Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267071AbSK2O0m>; Fri, 29 Nov 2002 09:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbSK2O0m>; Fri, 29 Nov 2002 09:26:42 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:35602 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S267071AbSK2O0l> convert rfc822-to-8bit; Fri, 29 Nov 2002 09:26:41 -0500
Date: Fri, 29 Nov 2002 15:34:01 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <1038580372.13625.8.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211291530220.29442-100000@grignard.amagerkollegiet.dk>
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

This is not DDR, it is SD-RAM (K6-2/300, 256MB SD-RAM in one stick).

But there is not much CPU traffic when making the files. The NFS-client
is doing the compression, but the corruption seems to happen on the
NFS-server (at least I can avoid it by turning off DMA on teh NFS
server), which has not got any special CPU usage at that time.

> So if its a VIA box, turn DMA back on, stick the bios into its load
> failsafe defaults mode and see if that has an affect.

I will try to look into BIOS settings (it does not have a 'load failsafe
option' IIRC, but I'm pretty sure I can change RAM timings) - but I
won't be near the machine before tomorrow.

Regards
/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
There is no insanity, just different perceptions of reality.
----------------------------------[ moffe at amagerkollegiet dot dk ] --

