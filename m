Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWA2Khq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWA2Khq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 05:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWA2Khq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 05:37:46 -0500
Received: from [207.253.5.75] ([207.253.5.75]:5903 "EHLO
	imailserver.sicon-sr.com") by vger.kernel.org with ESMTP
	id S1750876AbWA2Khp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 05:37:45 -0500
Message-ID: <002201c624bf$fdcc83b0$1701a8c0@gerold>
From: "Gerold van Dijk" <gerold@sicon-sr.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>, "Alwin" <d_j_d@hotmail.com>,
       "oswin martopawiro" <o_martopawiro@hotmail.com>,
       "guno" <guno@sicon-sr.com>, "albert" <albert@sicon-sr.com>
References: <000601c62370$db00cd50$1701a8c0@gerold> <200601271852.k0RIqaC0023706@turing-police.cc.vt.edu>
Subject: Re: traceroute bug ? 
Date: Sun, 29 Jan 2006 07:37:23 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1289
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1289
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Valdis et.al.,

thanks for biting! I really tested this thing thoroughly, with different 
distributions (Red Hat, SuSE 8.0 and 10.0) on different machines with the 
firewalls completely open, and without any router or switch involved: cross 
cable straight from one machine to another!

IF I ONLY CHANGE TO ANOTHER IP BLOCK (E.G. 206.253.5.64/24) OR A PRIVATE 
RANGE (E.G. 192.168.1.0/24) THE TRACEROUTE WORKS FINE! SO IT IS SPECIFICALLY 
THIS 207.253.5.0/24 BLOCK THAT DOES NOT TRACEROUTE WITHIN IT'S OWN RANGE!

Not only the subnetwork 207.253.5.64/27 but the whole class C block 
207.253.5.0/24 !?

Just to be complete: we CAN ping normally within this network!

But the traceroute simple displays "*  *  *" row after row!

Of course it is not that urgent a problem, cause what is the sense of doing 
a traceroute within your own network anyway? But I thought it might be 
useful to report this strange thing!

Thank you all for your time!

Regards,

Gerold H. van Dijk

Research & Training Manager

SICON; Suriname Information &
Communication Network

Verl.Gemenelandsweg 163
Paramaribo, Suriname
South America

(+597)    464791
(+597)    491510 (fax)
(+597)(0) 8579216 (gsm)

gerold@sicon-sr.com
gerold_vandijk@hotmail.com



On Fri, 27 Jan 2006 15:38:23 -0300, Gerold van Dijk said:
> Why can I NOT do a traceroute specifically within my own (sub)network
>
> 207.253.5.64/27
>
> with any distribution of Linux??

OK.. I'll bite.  What happens when you try?  And why are you posting here - 
is
there *any* evidence that there is a Linux kernel bug involved?

The output of 'ifconfig' and 'netstat -r -n' would likely be helpful, as 
would
proof that the host(s) you're tracerouting from and to are *not* running a
firewall that interferes with the way traceroute functions. (It's amazing 
how
many people block all ICMP, then wonder why traceroute doesn't work... ;)

Watching the wire with 'tcpdump' and/or 'ethereal' can also help....

