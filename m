Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRJEV0e>; Fri, 5 Oct 2001 17:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273524AbRJEV0Z>; Fri, 5 Oct 2001 17:26:25 -0400
Received: from web21108.mail.yahoo.com ([216.136.227.110]:31714 "HELO
	web21108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272540AbRJEV0J>; Fri, 5 Oct 2001 17:26:09 -0400
Message-ID: <20011005212638.92806.qmail@web21108.mail.yahoo.com>
Date: Fri, 5 Oct 2001 22:26:38 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: Re: [patch] Re: AMD viper chipset and UDMA100
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 28, 2001 at 10:21:14, Vojetch Pavlik wrote:
>
> On Thu, Sep 27, 2001 at 04:37:50PM -0700, Sean
Swallow wrote:
> 
> > Vojtech,
> > I would be interested in trying out your code.
>
> Ok. It should make your ViperPlus work with UDMA100.
> The patch is
> against 2.4.10, but will probably work with any
similar kernel. It
> completely replaces Andre's driver with mine. Find
it > attached.
> 
> Good luck. 
[patch snipped]
I have a Tyan K7 Thunder and I have tried this patch
and the patch from Andre, synced with 2.4.10 by Jacob
Luna and have had the same problem with both.  Without
the patch I can only do UDMA33 but the hw supports
UDMA100.  I have a Quantum FireballPlus AS40 on my
primary IDE channel which I have tested on an MSI
K7Master and works fine in UDMA100.

When I reboot with the driver enabled, as soon as hda
is detected the kernel locks up with a DIVIDE (0)
error.  I will try it again and take notes of more
details if it helps.

Without the driver, using the generic code I am able
to use the drive, in I think UDMA100 by letting the
BIOS set the drive to UDMA100 then manually setting
DMA mode on with hdparm.  However if I try to set the
modes manually with hdparm I can not select above
UDMA66.

I have tried this with kernel 2.4.10 and 2.4.11pre1.
My system is a Dual K7, SMP kernel, 512MB RAM.

My root filesystem is on a RAID0 array across 4
Quantum AtlasV 9GB U160 SCSI disks, two on each
channel of the onboard Adaptec.

I have tried to use the Fireball in the array as well
but for some reason performance reduced!  110MB/s with
hdparm -t compared to 70MB/s. Could this be because of
the lack of chipset driver?

One other thing is I am running with the preemt patch,
though I tested it without as well as I remember.

Please CC any replys to steven.newbury1@ntlworld.com
as  I am not on the list.
--
Steven Newbury


____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
