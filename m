Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSGRTUz>; Thu, 18 Jul 2002 15:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318334AbSGRTUz>; Thu, 18 Jul 2002 15:20:55 -0400
Received: from swisscheese.stickdog.net ([209.246.42.230]:27150 "EHLO
	swisscheese.stickdog.net") by vger.kernel.org with ESMTP
	id <S318333AbSGRTUx> convert rfc822-to-8bit; Thu, 18 Jul 2002 15:20:53 -0400
Date: Thu, 18 Jul 2002 15:10:31 -0400
From: Nathan Walp <faceprint@faceprint.com>
To: Allen McIntosh <mcintosh@research.telcordia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 and 19-rc1 IDE lockup on Dell Latitude
Message-ID: <20020718191031.GA17575@faceprint.com>
Reply-To: faceprint@faceprint.com
References: <200207181744.NAA24845@mc-pc.research.telcordia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200207181744.NAA24845@mc-pc.research.telcordia.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 01:44:07PM -0400, Allen McIntosh wrote:
> 2.4.18 and 2.4.19-rc1 lock up after a suspend/resume on my Dell Latitude
> CPi D300XT.
> 
> To recreate:  Suspend (using the suspend key, by closing the top, or
> using the apm command), then hit the power button for resume.  When the
> system wakes up some IDE I/O occurs (with flashing disk light and
> audible head motion), then the disk light comes on and stays on.
> Switching consoles is possible, and typed characters echo, but
> no commands run.  The system can be powered down by holding the power
> button down for 10 seconds, but that's about it.
> 
> The system seems stable otherwise.  It stayed up all last weekend, for
> example.
> 
> If you wait in the locked state long enough, the 2.4.14 and 2.4.18 kernels
> usually (but not always) output the following to the console:
> 
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> 
> Kernel versions I've tried this on:
> 
> 2.4.14, 2.4.18 (vanilla), 2.4.18-3 (RedHat), 2.4.19-rc1, 2.4.19-rc1-ac5

I've had similar problems with my Inspiron 4100.  If I leave it idle 
long enough (i think) and come back to it, it can work, but anything 
dealing with the disk just doesn't work.  Running any command results in
some sort of IO error.  I don't have it with me, so I don't have any of 
the details handy.  I was begining to suspect hardware failure on the 
part of the drive.  

However, suspending doesn't trigger the behavior.  I regularly suspend
it with no adverse effects.  

I believe I'm currently running one of the later 2.4.19-preX releases,
been meaning to upgrate it to a -rc kernel.

Hope someone can figure this out.


-- 
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E

