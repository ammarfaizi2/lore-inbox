Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTJ3AaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTJ3AaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:30:16 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:49127 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261539AbTJ3AaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:30:12 -0500
Message-Id: <200310300030.h9U0U4NB001760@ginger.cmf.nrl.navy.mil>
To: Lukasz Trabinski <lukasz@trabinski.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
In-Reply-To: Message from Marcelo Tosatti <marcelo.tosatti@cyclades.com> 
   of "Sat, 25 Oct 2003 18:39:21 -0200." <Pine.LNX.4.44.0310251839030.30825-100000@logos.cnet> 
Date: Wed, 29 Oct 2003 19:30:05 -0500
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, ATM dosen't work for me. (from 2.4.22, 2.4.21 is OK).
>No traffic via ATM interfeces.
>
>[root@voices root]# ifconfig atm1
>atm1      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-
>00-00
>          inet addr:XXX.XX.XX.XXX  Mask:255.255.255.252
>          UP RUNNING  MTU:9180  Metric:1
>          RX packets:9 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:100
>          RX bytes:632 (632.0 b)  TX bytes:100 (100.0 b)

this doesnt look bad. i see 1 tx packet and some rx packets.  how
did you test this interface?  does tcpdump show anything?  could you
be more specific about this configuration so i could try to duplicate
your setup?  the nicstar driver seems to work for me in the 2.4.23-pre8
kernel (ilmid, signalling).  i tested the clip module as well but that
was via an arp server not clip over a pvc.

>Counters on all atm interfeces are still the same

what does atmdiag show?

>On good working kernel, during boot, i have messages like this:
>
>atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
>atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
>atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
>atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
>atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)

these message were eliminated since they arent very useful and
quite noisy.
