Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313667AbSDHPHk>; Mon, 8 Apr 2002 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313669AbSDHPHj>; Mon, 8 Apr 2002 11:07:39 -0400
Received: from gw.wmich.edu ([141.218.1.100]:62143 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S313667AbSDHPHi>;
	Mon, 8 Apr 2002 11:07:38 -0400
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is
	enabled
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Anssi Saari <as@sci.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 11:06:28 -0400
Message-Id: <1018278394.570.143.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not completely sure about burning audio, but linux doesn't read
audio cds using DMA.  It just wont on ide devices.  You can use a patch
that allows this from andrew morton.  I dont write many audio cds so
I've never tested it's effect on writing a cd, only reading.  I imagine
it's not safe to use dma on raw/audio cds.  but go check it out
anyways.  


On Mon, 2002-04-08 at 10:54, Bill Davidsen wrote:
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
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


