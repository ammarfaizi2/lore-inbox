Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279382AbRJ2TRY>; Mon, 29 Oct 2001 14:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279389AbRJ2TRO>; Mon, 29 Oct 2001 14:17:14 -0500
Received: from tamago.synopsys.com ([204.176.20.21]:24760 "EHLO
	tamago.synopsys.com") by vger.kernel.org with ESMTP
	id <S279382AbRJ2TQ6>; Mon, 29 Oct 2001 14:16:58 -0500
Message-ID: <3BDDAB1E.11F14220@Synopsys.COM>
Date: Mon, 29 Oct 2001 20:16:46 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM> <3BDDA4C0.F4391EC@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> 
> Harald Dunkel wrote:
> >
> > Hi folks,
> >
> > Does anybody know what this message in kern.log means?
> >
> >         eth0: command 0x3002 did not complete! Status=0xffff
> >
> 
> There's a function in the driver which issues reset commands to the
> hardware and then spins, waiting for completion.  Usually it takes
> a single PCI cycle.  In your case it timed out.
> 
> It look to me like the NIC is powered down.  Could you please
> send me a bunch of info:
> 
> - Does the interface actually work after this message, or is
>   it dead?
> 

A ping to the assigned IP address works. But I cannot get a PPPoE
connection.

> - If the latter, did you warmboot from another OS?
> 
I've got just Linux. The problem occurs after a warm boot as
it seems. When I do a power-down reset, then I don't get this
message, but I don't get a connection via PPPoE, either.

> - Does it help if you add the line
> 
>         options 3c59x enable_wol=1
> 
>   to /etc/modules.conf?  (This is a misnomer - enable_wol
>   enables the driver's power management functions).
> 

No, this did not help. I found an old EMail with the suggestion 
to add enable_wol=0, but this didn't help, either.

The problem came up this morning (12 hours ago). Before the it was 
working, AFAICT.


Regards

Harri
