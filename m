Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbSJPDui>; Tue, 15 Oct 2002 23:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbSJPDui>; Tue, 15 Oct 2002 23:50:38 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:58756
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264846AbSJPDuh>; Tue, 15 Oct 2002 23:50:37 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: Simon Roscic <simon.roscic@chello.at>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3DACD41F.2050405@metaparadigm.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034740592.29313.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 15 Oct 2002 22:56:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might wanna look at version 6.01 instead. I say this because it's
*not* a beta driver. 


On Tue, 2002-10-15 at 21:51, Michael Clark wrote:
> Version 6.1b5 does appear to be a big improvement from looking
> at the code (certainly much more readable than version 4.x end earlier).
> 
> Although the method for creating the different modules for
> different hardware is pretty ugly.
> 
> in qla2300.c
> 
> #define ISP2300
> [snip]
> #include "qla2x00.c"
> 
> in qla2200.c
> 
> #define ISP2200
> [snip]
> #include "qla2x00.c"
> 
> I'm sure this would have to go before it got it.
> 
> ~mc
> 
> On 10/16/02 03:53, Simon Roscic wrote:
> > On Tuesday 15 October 2002 21:31, Arjan van de Ven <arjanv@redhat.com> wrote:
> > 
> >>Oh so you haven't notices how it buffer-overflows the kernel stack, how
> >>it has major stack hog issues, how it keeps the io request lock (and
> >>interrupts disabled) for a WEEK ?
> 
> This may have been the cause of problems I had running qla driver with
> lvm and ext3 - I was getting ooops with what looked like corrupted bufferheads.
> 
> This was happening in pretty much all kernels I tried (a variety of
> redhat kernels and aa kernels). Removing LVM has solved the problem.
> Although i was blaming LVM - maybe it was a buffer overflow in qla driver.
> 
> The rh kernel I tried had quite an old version (4.31) of the driver
> suffered from problems recovering from LIP resets. The latest 6.x drivers
> seem to handle this much better.
> 
> ~mc
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
