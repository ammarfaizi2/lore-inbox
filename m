Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132817AbRDIS3q>; Mon, 9 Apr 2001 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRDIS30>; Mon, 9 Apr 2001 14:29:26 -0400
Received: from iris.mc.com ([192.233.16.119]:38848 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S132815AbRDIS3S>;
	Mon, 9 Apr 2001 14:29:18 -0400
From: Mark Salisbury <mbs@mc.com>
To: Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com
Subject: Re: No 100 HZ timer !
Date: Mon, 9 Apr 2001 14:19:28 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com>
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com>
MIME-Version: 1.0
Message-Id: <01040914220214.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is one of linux biggest weaknesses.  the fixed interval timer is a
throwback.  it should be replaced with a variable interval timer with interrupts
on demand for any system with a cpu sane/modern enough to have an on-chip
interrupting decrementer.  (i.e just about any modern chip)

On Mon, 09 Apr 2001, Jeff Dike wrote:
> schwidefsky@de.ibm.com said:
> > I have a suggestion that might seem unusual at first but it is
> > important for Linux on S/390. We are facing the problem that we want
> > to start many (> 1000) Linux images on a big S/390 machine. Every
> > image has its own 100 HZ timer on every processor the images uses
> > (normally 1). On a single image system the processor use of the 100 HZ
> > timer is not a big deal but with > 1000 images you need a lot of
> > processing power just to execute the 100 HZ timers. You quickly end up
> > with 100% CPU only for the timer interrupts of otherwise idle images.
> 
> This is going to be a problem for UML as well, and I was considering something 
> very similar.  I did a quick scan of your prose, and the description sounds 
> like what I had in mind.
> 
> So, count me in as a supporter of this.
> 
> A small request: Since S/390 is not the only port that needs this, I'd be 
> happy if it was made as generic as possible (and it may already be, I haven't 
> gone through the code yet).
> 
> 				Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

