Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRFQMC2>; Sun, 17 Jun 2001 08:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264728AbRFQMCT>; Sun, 17 Jun 2001 08:02:19 -0400
Received: from mail.valinux.com ([198.186.202.175]:44561 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S264724AbRFQMCG>;
	Sun, 17 Jun 2001 08:02:06 -0400
Message-ID: <3B2C9ADA.6060506@valinux.com>
Date: Sun, 17 Jun 2001 04:56:10 -0700
From: "Jason T. Collins" <jcollins@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac15 i686; en-US; 0.8) Gecko/20010409
X-Accept-Language: en
MIME-Version: 1.0
To: justin@soze.net
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

justin@soze.net wrote:
 > I remember seeing something about how some via ide chipsets (686b I 
think)
 > and [some?] ide promise controllers had problems with data corruption on
 > the IBM dtla-series udma drives, and that IBM stated the problem was 
with
 > the controllers.  Is there a chance a problem like that could be 
screwing
 > up the kernel?

I recently upgraded my system so it now (undeliberately!) seems to 
reproduce every problem ever mentioned here or elsewhere with regards to 
the VIA chipset -- I now have/have had the VIA timer bug (fixed due to 
patch), SB Live problems (seem to be resolved, card shuffling), nVidia 
crashing, and IDE lockups similiar to those mentioned earlier in this 
thread.  There's almost enough material for a VIA on Linux FAQ...

In addition, I had the IBM+Promise+VIA problem.  Moving the drive to my 
on-board 686A as others have done has solved it..  before that, Cerberus 
didn't last more than about 30 seconds with DMA enabled before causing 
random trashing of memory and other nasty disasters. 

Now I get about 3-10 minutes in and bizarrely, Linux just gives up -- 
disk access stops for no apparent/printked reason, and no amount of 
tweaking DMA settings or VM parameters seems to change that, unless I 
disable DMA completely.  In-memory programs keep running, but anything 
needing disk access blocks indefinitely.  What's weirder is, in about 
10% of the crashes (I've done this a LOT), hitting Alt-SysRq-S (sync) a 
couple times knocks the system out of the state and Cerberus will run as 
normal for about 5 or 10 more minutes and crash again.  :/  At least it 
isn't corrupting data.

I think we're trying to debug about a half dozen critical problems all 
at the same time here. ;)

To contribute to the hardware matching:

Jason's Box:
Abit KA7 (KX133, VIA686A Southbridge) / Athlon 850, latest BIOS
512 MB CAS2 PC133 SDRAM (Mushkin)
Promise Ultra100 (2.01 B 27 BIOS, latest)
OHCI-1394 Firewire Controller (Texas Instruments)
Bt878 video capture card
Creative Labs CT4620 SB Live!
nVidia GeForce 2 MX 64 MB (NV11 rev b2, LeadTek, latest BIOS)

hda=QUANTUM FIREBALLP LM20.5, FwRev=A35.0700, SerialNo=184006731872
hdb=IBM-DTLA-307060, FwRev=TX8OA50C, SerialNo=YQDYQFHT566
hdc=Pioneer DVD-ROM ATAPIModel DVD-104S 020, FwRev=E2.02, SerialNo=
hde=Maxtor 54610H6, FwRev=JAC61HU0, SerialNo=F600VF1D
hdg=Maxtor 54610H6, FwRev=JAC61HU0, SerialNo=F600TNTD


Jason T. Collins
Software Engineer
VA Linux Systems


