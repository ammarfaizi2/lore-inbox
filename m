Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273358AbRJKHGF>; Thu, 11 Oct 2001 03:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273360AbRJKHFz>; Thu, 11 Oct 2001 03:05:55 -0400
Received: from [213.45.102.230] ([213.45.102.230]:57608 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S273358AbRJKHFv>; Thu, 11 Oct 2001 03:05:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Tulip problem in Kernel 2.4.11
In-Reply-To: <000701c151c4$0e6933e0$0300a8c0@theburbs.com>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 11 Oct 2001 09:06:17 +0200
In-Reply-To: <000701c151c4$0e6933e0$0300a8c0@theburbs.com>
Message-ID: <87u1x6zmdy.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Jamie" == Jamie  <darkshad@home.com> writes:

    > Hello there is a definate problem with the tulip drivers in the 2.4.11
    > kernel.
    > I have a DEC DC 21041 NIC which uses the tulip drivers.  I use the 2.2.19
    > kernel and there are
    > two different sets of tulip drivers listed in that kernel which
    > I can choose 
    > from in the 2.4.11 kernel there is only one. When I do a
    > modprobe tulip the 
    > driver loads fine as you can see bellow there are no strange
    > error messages 
    > ect.  But I can not communicate though this one NIC. When I use
    > the 2.2.19 
    > Kernel it works fine.

I can add to this that 2.4.2 works fine, I've tried 2.4.9 and 2.4.11
and I can't use the lan either. 
In 2.4.11, I can see that the driver can sense if I plug/unplug the
connector (10BaseT, connected to a Compaq Netelligent 8 port hub), but
nothing more.

here's what 2.4.2 says about the card:

# lspci -v -v -s 00:03.0
00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 11)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at fc00 [size=128]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at de000000 [disabled] [size=256K]

I am now trying to compile again 2.4.11 with the driver as module,
instead of built-in, just to see if I can pass some parameters to
force a media type without rebooting every time.

Please suggest any other test I can make, or if you need more informations.

Pf

-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.7 #1 Thu Jul 26 14:48:56 CEST 2001 i686 unknown
