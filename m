Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262814AbRE3Vv3>; Wed, 30 May 2001 17:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262816AbRE3VvV>; Wed, 30 May 2001 17:51:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:22204 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262814AbRE3VvI>;
	Wed, 30 May 2001 17:51:08 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
Date: Wed, 30 May 2001 23:48:10 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <E154iiK-0004Mb-00@the-village.bc.nu> <3B136639.D883F0C8@mail.utexas.edu>
In-Reply-To: <3B136639.D883F0C8@mail.utexas.edu>
MIME-Version: 1.0
Message-Id: <01053023481000.00375@antares>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 May 2001 11:04, Bobby D. Bryant wrote:
> Alan Cox wrote:
> > > May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
> > > May 22 21:45:07 pollux kernel: ide0: ALI15X3 Bus-Master DMA disabled
> > > (BIOS)
> > > May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
> > > May 22 21:45:07 pollux kernel: ide1: ALI15X3 Bus-Master DMA disabled
> >
> > The DMA was off because the BIOS left it off.
>
> I just checked, and the BIOS auto-detect page for that drive shows PIO Mode
> 4 and Ultra DMA Mode 5.  The BIOS also shows a summary chart during boot,
> just before the LILO prompt, and that summary also reports UDMA 5 for that
> drive. It really looks like the kernel is not getting the correct device
> info from the BIOS.

Just a blind guess, but this reminds me of a similar problem I had with 
a different Athlon board a while ago. The BIOS and the driver disagreed
on the bits through which DMA capability was signalled. The fix that worked
for me was to enable both IDE channels (and use up two interrupts) though
I needed only the first channel.

-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
