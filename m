Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTFVRrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTFVRrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:47:35 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:8064 "EHLO server")
	by vger.kernel.org with ESMTP id S264864AbTFVRrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:47:32 -0400
Message-ID: <07cf01c338e8$4f12b4e0$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz> <20030621200617.648c5ec2.akpm@digeo.com>
Subject: Re: kswapd 2.4.2? ext3
Date: Sun, 22 Jun 2003 11:01:27 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same problem, but I never get a oops, because the system is
completely locked up. The wierd part about this is that if I leave a command
prompt open, I can type in a command, but it never gets executed. I even
tried to use the sysrq to get information and that doesn't even work,
because syslog is dead. Here is my system information. After about 20 hours
uptime server locks up.

Dell Poweredge 4200
2 - Pentium II - 333mhz
1 GIG ECC EDO RAM
Dell Perc2(Megaraid Controller) - Setup as WriteThru and DirectIO
Adaptec Duo Network Adapter

Using kernel 2.4.21 with the latest 1.18i driver from LSILogic for the
Megaraid, no other patches, built from source code only

I am a Linux From Scratch  user, I have used the same config file since
kernel 2.4.17 with no problems, problems first appeared in kernel 2.4.20. I
have had the  system checked, the memory tested, and changed raid
controllers. I have even checked cron events at the time it locks up

If you have a patch you would like me to test send it and I can report back
in 24 hours. I do have the capability of hooking up a laptop to the serial
port of the computer to collect statistics.

----- Original Message ----- 
From: "Andrew Morton" <akpm@digeo.com>
To: <john@beyondhelp.co.nz>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, June 21, 2003 8:06 PM
Subject: Re: kswapd 2.4.2? ext3


> John Duthie <john@beyondhelp.co.nz> wrote:
> >
> >
> > I don't think kswap should be doing this ....
> >
> >     4 ?        Z      0:14 [kswapd] <defunct>
>
> That means kswapd oopsed and then exitted.  It should be in the logs
> somewhere.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

