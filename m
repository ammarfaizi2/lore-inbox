Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSA1RSn>; Mon, 28 Jan 2002 12:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSA1RSf>; Mon, 28 Jan 2002 12:18:35 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:34634 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S289270AbSA1RSU>; Mon, 28 Jan 2002 12:18:20 -0500
Date: Mon, 28 Jan 2002 18:13:40 +0100
From: Kristian <kristian.peters@korseby.net>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: akpm@zip.com.au, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-Id: <20020128181340.280af0fa.kristian.peters@korseby.net>
In-Reply-To: <1012233006.951.2.camel@psuedomode>
In-Reply-To: <3C550BD4.E9CBE6A@zip.com.au>
	<3C550BD4.E9CBE6A@zip.com.au>
	<20020128095136.1298@mailhost.mipsys.com>
	<3C551F18.873EA52E@zip.com.au>
	<1012233006.951.2.camel@psuedomode>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <ed.sweetman@wmich.edu> wrote:
> I've always been able to get it back to dma for packet by forcing the
> drive to sleep mode and then letting the kernel wake it.   I guess I'll
> try this 3rd version patch when I get back from class today and see if
> that still works.   
> 
> hdparm -Y /dev/cdrom    
> 
> then go and set dma again with hdparm.   
> 
> Although this could just be fickleness of my cdrom.  

It works for the second one (the HP writer). But the kernel completely hangs for 2 seconds trying to wake up the drive (with 2.4.18-pre3-ac2).

My log shows:
 hdd: DMA disabled
 hdd: drive not ready for command
 hdd: ATAPI reset complete

But preemption does help in that case.

The first cd-rom drive does not support sleep or standby commands. ;-(

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
