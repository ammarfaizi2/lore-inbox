Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSK0AZO>; Tue, 26 Nov 2002 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSK0AZO>; Tue, 26 Nov 2002 19:25:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:25492 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261861AbSK0AZN>; Tue, 26 Nov 2002 19:25:13 -0500
Subject: Re: 2.5.49: Severe PIIX4/ATA filesystem corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DE40E29.4040408@zytor.com>
References: <as0nq9$vnu$1@cesium.transmeta.com>
	<1038357146.2658.105.camel@irongate.swansea.linux.org.uk> 
	<3DE40E29.4040408@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 01:03:41 +0000
Message-Id: <1038359021.3267.110.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 00:13, H. Peter Anvin wrote:
> Yes, that's true.  However, the heavily used two SCSI disks saw no 
> corruption whatsoever, whereas the single, lightly used ATA disk saw 
> heavy corruption; if it was due to experimental unrelated code one would 
> have expected corruption everywhere.  This does not mean that it is not 

IDE does handle the I/O quite differently so Im not sure about that.
Accidentally fiddling with an in flight request tends to do horrible
things on IDE but not on scsi for example.

The base 2.5.47/8/9 Linus tree PIIX code has had no corruption reports
(except someone whose box failed memtest86) and its about the most
tested IDE controller.

I would be interested to know what happens if you boot a base 2.5.49
without raid6 adulteration and stress it on your hw there, just to be
sure.

