Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268587AbRGYQhY>; Wed, 25 Jul 2001 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268589AbRGYQhO>; Wed, 25 Jul 2001 12:37:14 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:53778 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268587AbRGYQgx>;
	Wed, 25 Jul 2001 12:36:53 -0400
Message-Id: <200107250222.GAA00764@mops.inr.ac.ru>
Subject: Re: pppoe patch in 2.4.7 results - still problem
To: saai@swbell.NET (Andrew Friedley)
Date: Wed, 25 Jul 2001 06:22:23 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, davem@redhat.COM
In-Reply-To: <000901c112d6$a1a30000$0200a8c0@loki> from "Andrew Friedley" at Jul 22, 1 09:45:00 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Call Trace: [<c01d706b>] [<c01d7653>] [<c01da0f7>] [<c01ddfed>] [<c01e7ea0>]
> [<c01e7f60>] [<c01df228>]
>        [<c01e5450>] [<c01e7e83>] [<c01e7ea0>] [<c01e54aa>] [<c01df228>]
> [<c01e05
>        [<c01e4488>] [<c01e462a>] [<c01e4488>] [<c01df228>] [<c01e42c7>]
> [<c01e44
>        [<c0108680>] [<c0105180>] [<c0106d40>] [<c0105180>] [<c01051ac>]
> [<c01052
> Code: 8b 1b 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f 94 c0 84 c0 74
> 
> >>EIP; c01d6fc3 <skb_copy_bits+47/1e8>   <=====
> Trace; c01d706b <skb_copy_bits+ef/1e8>
> Trace; c01d7653 <skb_copy_and_csum_dev+7b/cc>
> Trace; c01da0f7 <dev_change_flags+67/f8>
> Trace; c01ddfed <nf_iterate+41/84>
> Trace; c01e7ea0 <ip_setsockopt+d4/944>

You use __WRONG__ vmlinux, so that this call trace is totally useless.
Please, find right vmlinux and get symbolic info from it. 

[ Dave, disassembled function is not skb_copy_bits()... and so on.
  So that skb_copy_and_csum_dev is innocent. ]

Alexey
