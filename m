Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaMPK>; Sun, 31 Dec 2000 07:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaMPB>; Sun, 31 Dec 2000 07:15:01 -0500
Received: from www.wen-online.de ([212.223.88.39]:58130 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129324AbQLaMOs>;
	Sun, 31 Dec 2000 07:14:48 -0500
Date: Sun, 31 Dec 2000 12:44:22 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problem test13-pre7
In-Reply-To: <20001231132850.C28963@mea-ext.zmailer.org>
Message-ID: <Pine.Linu.4.10.10012311237420.1563-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Matti Aarnio wrote:

> On Sun, Dec 31, 2000 at 10:42:26AM +0100, Mike Galbraith wrote:
> > Hi,
> > 
> > While running iozone, I notice severe stalls of vmstat output
> > despite vmstat running SCHED_RR and mlockall().
> 
>    Lets eliminate the obvious:
> 
>    - Are you running with IDE disk ?

Yes.

>    - Does   hdparm  /dev/hda(whatever)    report:
> 
> 	/dev/hda:
> 	 unmaskirq    =  0 (off)
> 	 using_dma    =  0 (off)

No.

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2482/255/63, sectors = 39876480, start = 0

> 
>    The IKD uses local interrupts, so this isn't necessarily true...

I just did a (mondo) trace covering 8 seconds of kernel time, and
vmstat ran twice.  (Those two times were before I noticed the stall
and started counting down toward 'poke the freeze-frame button')

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
