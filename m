Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbSIZM3s>; Thu, 26 Sep 2002 08:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbSIZM3s>; Thu, 26 Sep 2002 08:29:48 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:35060 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S262241AbSIZM3q>; Thu, 26 Sep 2002 08:29:46 -0400
Message-Id: <5.0.2.6.2.20020926182552.0506a898@sdl99c>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2-Jr1
Date: Thu, 26 Sep 2002 21:36:52 +0900
To: robert@schwebel.de, lkst-develop@lists.sourceforge.jp
From: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
Subject: Re: [Lkst-develop] Re: Release of LKST 1.3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020919055843.GC10773@pengutronix.de>
References: <5.0.2.6.2.20020918210036.05287a40@sdl99c>
 <5.0.2.6.2.20020918210036.05287a40@sdl99c>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Robert

   Thank you for your inquiry. I apologize for the delay in replying.

   Let me first explain the background of our development work.
   We began development of the Linux Kernel State Tracer (LKST)
in response to a domestic need to improve Reliability, Availability,
and Serviceability (RAS) with respect to enterprise systems.
The following requirements were applied to LKST:

   * Capable of handling a variety of information about system errors.
   * Little trace overhead (or To control trace overhead)
   * Short development time

   As we had to achieve a short development time, we elected to
develop LKST using our own methodology (based on know-how of
tracer development that we carried out for other OS's) different
from other known tools such as LTT.
# This is not to say that we developed all functions on our own.
#LKST at present connects with Kernel Hooks (GKHI) and LKCD.

   Consequently, LKST, which is oriented to enterprise systems,
has the following features different from those of LTT.
# These LKST features are also being enhanced at this time.

(1) Little overhead and good scalability when tracing on a large-scale
    SMP system
   * To make lock mechanism overhead as little as possible, we
      designed that the buffers are not shared among CPUs.

(2) Easy to extend/expand the function (User-based extendibility)
   * Without recompiling kernel, user can change/add/modify the kind
     of events and information to be recorded at anytime.
      For example, LKST usually traces very few events for the purpose
    of good performance.  Once the kernel get into the particular status
    that user specified, LKST will trace and record more detail information.

(3) Preservation of trace information
   * Recovery of trace information collected at the time of a system crash
     in connection with LKCD.
   * Saving of specific event information during tracing.
      For example, switching to another buffer after the occurrence of
     a specific event enables the information on that event to be left
     in the previous buffer.

(4) Collection of even more kernel event information
   * Information on more than 50 kernel events can be collected for
     kernel debugging.

  The demand for RAS functions in Linux should grow in the years to come.
It is our hope that LKST becomes one means of implementing such functions.


Best regards,
----------------
  Yumiko Sugita
  Hitachi,Ltd., Systems Development Laboratory


At 07:58 02/09/19 +0200, Robert Schwebel wrote:
>On Wed, Sep 18, 2002 at 09:20:55PM +0900, Yumiko Sugita wrote:
> > I'd like to announce publication of Linux Kernel State Tracer (LKST)
> > 1.3, which is a tracer for Linux kernel.
>
>Can you tell us what's the difference between this and the Linux Trace
>Toolkit (LTT)?
>
>Robert
>--
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Braunschweiger Str. 79,  31134 Hildesheim, Germany
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>     Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
>_______________________________________________
>Lkst-develop mailing list
>Lkst-develop@lists.sourceforge.jp
>http://lists.sourceforge.jp/cgi-bin/mailman/listinfo/lkst-develop

