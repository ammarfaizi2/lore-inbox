Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313664AbSDHO5A>; Mon, 8 Apr 2002 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313665AbSDHO47>; Mon, 8 Apr 2002 10:56:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41221 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313664AbSDHO47>; Mon, 8 Apr 2002 10:56:59 -0400
Date: Mon, 8 Apr 2002 10:54:29 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Anssi Saari <as@sci.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
In-Reply-To: <20020408122603.GA7877@sci.fi>
Message-ID: <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Anssi Saari wrote:

> [1.] One line summary of the problem:    
> CD burning at 16x uses excessive CPU, although DMA is enabled

  That's a hint things are not working as you expect...
 
> [2.] Full description of the problem/report:
> My system seems to use a lot of CPU time when writing CDs at 16x. The
> system is unable to feed the burning software's buffer fast enough when
> burning software (cdrecord 1.11a20, cdrdao 1.1.5) is run as normal user.
> If run as root, system is almost unresponsive during the burn.

  With all the information you provided, you have totally not quatified
how much CPU you find "excessive." I would not be surprised to see 10-15%
of the CPU, virtually all in system time, as a normal burn of an ISO
image. If the time is in user mode with other image types, it may well be
that you are doing something which actually requires a lot of CPU (byte
swapping or some such).

  Going from a disk to a CD using DMA on both should not take much
*system* CPU, even if these are ATAPI (assuming they are not on the same
cable).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

