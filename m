Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135561AbRA2QjZ>; Mon, 29 Jan 2001 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135286AbRA2QjQ>; Mon, 29 Jan 2001 11:39:16 -0500
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:12561 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S135671AbRA2QjH>; Mon, 29 Jan 2001 11:39:07 -0500
Date: Mon, 29 Jan 2001 17:39:03 +0100 (MEZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Nathan Black <NBlack@md.aacisd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bolck Device problem or Compaq Smart array 2 problem? kernel -2.4 .0+
In-Reply-To: <8FED3D71D1D2D411992A009027711D671859@md>
Message-Id: <Pine.A32.3.95.1010129172907.41886A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Nathan Black wrote:

> 
> Here is my scenario. I have a smart array controller 2. I have 6 logical
> drives( one on it's own physical drive). I am using the one drive for data
> aquisition from an atm board. To locate my problem, I removed all of the atm
> stuff. and I am trying just a read/write. Both show the same symptoms. I
> have tried many different kernels.
> 
> Here are my results.
> 
> 2.2.18- works fine. 24 MBytes/sec at 100+ gigabytes (16GB looped many times
> ( lseek64(FD,SEEK_SET,0) )).
> 
> 2.4.0 release SMP and Uniprocessor with NMI on-	Kernel oops. I can reproduce
> if necessary( oops at about 700 MB)  sometimes more, sometime less. (In
> BDFLUSH if I recall)
> 
> 2.4.0 release UniProcessor NMI off- Works like the 2.2.18

Esp. for SMP problems (that is running on an SMP machine). Proper setup of
the board, the APIC and what else is mandatory.

For the Proliant, you should check the operating system setting with the
compaq setup tool/diagnosis. Definitely first upgrade all firmware to the
latest release... The new releases usually already support the setting:
linux. However, private experience:

   DOS/other       -- works, but UP only,
   linux           -- only on new machines, one case known where it
                      doesn't work.
   Windows NT      -- known not to work on old machines, but works in
                      above case where linux doesn't.
   Unixware (v7?)  -- some SMP unix, works on old machines, again doesn't
                      work on some new hardware.

So, you might have to try several settings. Even if 2.2.18 works, 2.4's 
setup might need other, better hardware initialisation.

If this doesn't help (or you knew about it and just didn't mention it).
I'd more think about hardware/CPU (esp. SMP setup)/memory problems.
I don't see the raid adapter affected here.

If all this doesn't help, you might want to contact Compaq, they are
recently very helpful to resolve such issues. 

How do lesser CPU's work?

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
