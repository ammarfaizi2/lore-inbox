Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSG3Ao0>; Mon, 29 Jul 2002 20:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317503AbSG3Ao0>; Mon, 29 Jul 2002 20:44:26 -0400
Received: from mail.MtRoyal.AB.CA ([142.109.10.24]:13278 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S317347AbSG3AoZ>; Mon, 29 Jul 2002 20:44:25 -0400
Date: Mon, 29 Jul 2002 18:47:32 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Andrew Theurer <habanero@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <200207291558.47266.habanero@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207291838160.20963-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Andrew Theurer wrote:

> On Monday 29 July 2002 4:28 pm, Alan Cox wrote:
> > Its quite possible the irq routing ought to be smarter, at the moment
> > I'm not sure of the best approaches.
> 
> Agreed, we need some sort of irqbalance, and I intend to test with Ingo's and 
> Andrea's approaches. With that addition, I may even see an improvement with 
> hyperthreading. But for an rc release, I think it would be prudent to revert 
> the "new code" for default hyperthreading behavior, and attack the whole 
> problem in 2.4.20 or later release.

Ingo Molnars patches for .17 and .18 worked
well for us, and did balance the ints load across all the CPUs very well.

You can find the patches I used agains 2.4.18 at
http://www.hardrock.org/kernel/

BTW, this was on a production box for approximately one month,
then the box mysteriously crashed.  Due to the fact that our load wasn't
utilizing the hyperthreading that much I removed acpismp=force from the
boot string.

The are balanced across the 2 real CPUs.

Regards
James Bourne
> 
> -Andrew Theurer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."


