Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313770AbSDHVxk>; Mon, 8 Apr 2002 17:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313775AbSDHVxf>; Mon, 8 Apr 2002 17:53:35 -0400
Received: from mark.mielke.cc ([216.209.85.42]:49935 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S313770AbSDHVxd>;
	Mon, 8 Apr 2002 17:53:33 -0400
Date: Mon, 8 Apr 2002 17:45:29 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Anssi Saari <as@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020408174529.A546@mark.mielke.cc>
In-Reply-To: <20020408122603.GA7877@sci.fi> <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the fact that it works with FreeBSD should have been enough
to show that 'excessive' doesn't need to be qualified.

The question is, how is CD burning of raw data different from
CD burning of ISO images, in respect to Linux drivers for the
hardware, and why does FreeBSD not suffer from this ailment?

mark


On Mon, Apr 08, 2002 at 10:54:29AM -0400, Bill Davidsen wrote:
> On Mon, 8 Apr 2002, Anssi Saari wrote:
> 
> > [1.] One line summary of the problem:    
> > CD burning at 16x uses excessive CPU, although DMA is enabled
> 
>   That's a hint things are not working as you expect...
>  
> > [2.] Full description of the problem/report:
> > My system seems to use a lot of CPU time when writing CDs at 16x. The
> > system is unable to feed the burning software's buffer fast enough when
> > burning software (cdrecord 1.11a20, cdrdao 1.1.5) is run as normal user.
> > If run as root, system is almost unresponsive during the burn.
> 
>   With all the information you provided, you have totally not quatified
> how much CPU you find "excessive." I would not be surprised to see 10-15%
> of the CPU, virtually all in system time, as a normal burn of an ISO
> image. If the time is in user mode with other image types, it may well be
> that you are doing something which actually requires a lot of CPU (byte
> swapping or some such).
> 
>   Going from a disk to a CD using DMA on both should not take much
> *system* CPU, even if these are ATAPI (assuming they are not on the same
> cable).

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

