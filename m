Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbSK2NxR>; Fri, 29 Nov 2002 08:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbSK2NxR>; Fri, 29 Nov 2002 08:53:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:5273 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267042AbSK2NxQ> convert rfc822-to-8bit; Fri, 29 Nov 2002 08:53:16 -0500
Subject: Re: [PROBLEM] NFS trouble - file corruptions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rasmus =?ISO-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211291410240.29442-100000@grignard.amagerkollegiet.dk>
References: <Pine.LNX.4.44.0211291410240.29442-100000@grignard.amagerkollegiet.dk>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Nov 2002 14:32:52 +0000
Message-Id: <1038580372.13625.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-29 at 13:17, Rasmus Bøg Hansen wrote:
> I just tried turning off DMA on the server disk (this is just a low-end
> IDE-system): No errors in files (compressing the file thrice).
> 
> So it does not at all seem to be a NFS-issue!
> 
> I have no idea what is wrong. If the disk, cable or IDE controller does
> bit-flipping when DMA is turned on, why is the problem only seen with
> NFS? I have never seem corrupted files or metadata with DMA turned
> (except once long ago, when I experimented with high-transfer-modes - I
> haven't done that since)...

More likely it changes the timings. There is at least one other
possibility though. With some via bridges using slightly too slow DDR
RAM at a 133MHz clock works reliably _until_ you get a mix of CPU and
DMA traffic. It'll even pass memtest86.

So if its a VIA box, turn DMA back on, stick the bios into its load
failsafe defaults mode and see if that has an affect.

Alan

