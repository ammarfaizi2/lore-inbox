Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTDKJKm (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTDKJKl (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:10:41 -0400
Received: from [203.197.168.150] ([203.197.168.150]:37390 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263337AbTDKJJ5 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 05:09:57 -0400
Message-ID: <3E9689B6.40753C53@tataelxsi.co.in>
Date: Fri, 11 Apr 2003 14:54:07 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Phillips <phillim2@comcast.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: setting LAA in token ring
References: <3E94FAB6.49465DC2@tataelxsi.co.in> <20030410210222.GA28094@siasl.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Phillips wrote:

> On Thu, Apr 10, 2003 at 10:31:42AM +0530 or sometime in the same epoch, Prasanta Sadhukhan scribbled:
> > Hi,
> >     Our cardbus driver   supports LAA but when
> > we are giving this command 'ifconfig  tr0 hw tr 4000DEADBEEF' but we are
> > getting
> > SIOCSIFHWADDR: Invalid argument
> >
> > Is there any prerequisites fot this command to be given?
> >
>
> There is a requirement for certain bit in the MSB to be set, bit 6 of 7
> iirc.
>
> Also, there is an issue with ifconfig and TR. During the 2.3 dev kernels
> we changed the IEEE type of TR from 6 to a value in the 800 range. This
> was done when multicast support was added as we needed to split out TR
> from the other 802 protocols.
>
> ifconfig and friends didn't realize this and barf because the return
> type is wrong. I've tried submitting patches to net-tools for this
> several times, but it wasn't fixed. It may be by now, but don't quote me
> on it.

But the LAA feature was working in RH 7.1 which is kernel 2.4.2-2
So why suddenly this feature is returning Invalid argument in 7.2 7.3 and 8.0.
Does it mean SIOCSIFHWADDR is not supported in the kernel


>
>
> Mike Phillips
> Linux Token Ring Project
> http://www.linuxtr.net
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
-----------------------------------------------------------------------
|            __    __          | Tata Elxsi Ltd         |
|           / ,, /| |'-.       | http://www.tataelxsi.com             |
|          .\__/ || |   |      |===================================== |
|       _ /  `._ \|_|_.-'      | Prasanta Sadhukhan                   |
|      | /  \__.`=._) (_       |  mailto:prasanta_sadhukhan@yahoo.com |
|      |/ ._/  |"""""""""|     |  Bangalore                           |
|      |'.  `\ |         |     |  India                               |
|      ;"""/ / |         |     |                                      |
|       ) /_/| |.-------.|     |                                      |
|      '  `-`' "         "     |                                      |
----------------------------------------------------------------------


