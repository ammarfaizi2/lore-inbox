Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313658AbSDPJbj>; Tue, 16 Apr 2002 05:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313660AbSDPJbi>; Tue, 16 Apr 2002 05:31:38 -0400
Received: from [195.173.53.244] ([195.173.53.244]:25352 "HELO BELLE")
	by vger.kernel.org with SMTP id <S313658AbSDPJbh>;
	Tue, 16 Apr 2002 05:31:37 -0400
Subject: RE: Why HZ on i386 is 100 ?
From: Liam Girdwood <l_girdwood@bitwise.co.uk>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Olaf Fraczyk <olaf@navi.pl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <AAEGIMDAKGCBHLBAACGBEEONCEAA.balbir.singh@wipro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 11:29:07 +0100
Message-Id: <1018952961.31914.446.camel@swordfish>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 09:18, BALBIR SINGH wrote:
> I remember seeing somewhere unix system VII used to have HZ set to 60
> for the machines built in the 70's. I wonder if todays pentium iiis and ivs
> should still use HZ of 100, though their internal clock is in GHz. 
> 
> I think somethings in the kernel may be tuned for the value of HZ, these
> things would be arch specific.
> 
> Increasing the HZ on your system should change the scheduling behaviour,
> it could lead to more aggresive scheduling and could affect the
> behaviour of the VM subsystem if scheduling happens more frequently. I am
> just guessing, I do not know.
> 

I remember reading that a higher HZ value will make your machine more
responsive, but will also mean that each running process will have a
smaller CPU time slice and that the kernel will spend more CPU time
scheduling at the expense of processes. 


HTH 

Liam Girdwood

> Changing though trivial would require a good look at all the code that
> uses HZ.
> 
> Comments,
> Balbir
> 
> |-----Original Message-----
> |From: linux-kernel-owner@vger.kernel.org
> |[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of William Lee
> |Irwin III
> |Sent: Tuesday, April 16, 2002 1:45 PM
> |To: Olaf Fraczyk
> |Cc: linux-kernel@vger.kernel.org
> |Subject: Re: Why HZ on i386 is 100 ?
> |
> |
> |On Tue, Apr 16, 2002 at 09:47:48AM +0200, Olaf Fraczyk wrote:
> |> Hi,
> |> I would like to know why exactly this value was choosen.
> |> Is it safe to change it to eg. 1024? Will it break anything?
> |> What else should I change to get it working:
> |> CLOCKS_PER_SEC?
> |> Please CC me.
> |> Regards,
> |> Olaf Fraczyk
> |
> |I tried a few times running with HZ == 1024 for some testing (or I guess
> |just to see what happened). I didn't see any problems, even without the
> |obscure CLOCKS_PER_SEC ELF business.
> |
> |
> |Cheers,
> |Bill
> |-
> |To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> |the body of a message to majordomo@vger.kernel.org
> |More majordomo info at  http://vger.kernel.org/majordomo-info.html
> |Please read the FAQ at  http://www.tux.org/lkml/
> ----
> 

> **************************Disclaimer************************************
>       
> 
> 
> Information contained in this E-MAIL being proprietary to Wipro Limited
> is 'privileged' and 'confidential' and intended for use only by the
> individual or entity to which it is addressed. You are notified that any
> use, copying or dissemination of the information contained in the E-MAIL
> in any manner whatsoever is strictly prohibited.
> 
> 
> 
>  ********************************************************************
-- 
Liam Girdwood
l_girdwood@bitwise.co.uk (Work)
liam@nova-ioe.org (Home)

