Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVL3Hmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVL3Hmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVL3Hmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:42:42 -0500
Received: from webmail-outgoing2.us4.outblaze.com ([205.158.62.67]:39333 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1750803AbVL3Hml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:42:41 -0500
X-OB-Received: from unknown (205.158.62.232)
  by wfilter.us4.outblaze.com; 30 Dec 2005 07:42:41 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Kai Geek" <kaigeek@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Dec 2005 15:42:41 +0800
Subject: Re: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
X-Originating-Ip: 194.125.232.2
X-Originating-Server: ws5-11.us4.outblaze.com
Message-Id: <20051230074241.41333CA0A3@ws5-11.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i am inframed trace for irq14 bugging points. 

> * Lee Revell <rlrevell@joe-job.com> wrote:

> > It seems that either some code path really is forgetting to 
> > re-enable interrupts, or there's a bug in the latency tracer. 
> one question is, what do the kernel addresses visible in the first
> argument of asm_do_IRQ() correspond to:
>   trace1:MyThread-153   0D..1 5977us+: asm_do_IRQ (c030c170 1a 0)
>   trace1:MyThread-153   0D..1 15191us+: asm_do_IRQ (c030c1bc 1a 0)
>   trace2:  <idle>-0     0D..2 8822us+: asm_do_IRQ (c021da24 1a 0)
>   trace2:  <idle>-0     0Dn.2 8920us+: asm_do_IRQ (c021da24 b 0)
>   trace3:     top-169   0D..1 8802us+: asm_do_IRQ (c024e5fc 1a 0)
>   trace4:  insmod-185   0D..1 8794us+: asm_do_IRQ (c030c174 1a 0)
>   trace5:      dd-197   0D..1 8812us+: asm_do_IRQ (c02e4938 1a 0)
>   trace6: kthread-11    0d..3 2670us+: asm_do_IRQ (c02fe2d0 1a 0)
>   trace7:MyThread-95    0D..1  542us+: asm_do_IRQ (c02fe2d0 1a 0)
>   trace7:MyThread-95    0D..1 9755us+: asm_do_IRQ (c02fe2d0 1a 0)
> i.e. what is c02fe2d0, c021da24, c02e4938, etc.?
> but it seems most of the latencies are printk related: one possibility
> is that something is doing a costly printk with preemption disabled.
> 	Ingo
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

+-+-+-+ BEGIN PGP SIGNATURE +-+-+-+
Version: GnuPG v1.4.2 (GNU/Linux)
   .-.      .-.    _              
   : :      : :   :_;             
 .-' : .--. : `-. .-. .--.  ,-.,-.
' .; :' '_.'' .; :: :' .; ; : ,. :
`.__.'`.__.'`.__.':_;`.__,_;:_;:_;

Kai "Ozgur" Geek
Network Engineer
PGP ID: B1B63B6E
+-+-+-+ END PGP SIGNATURE +-+-+-+


-- 
_______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org
This allows you to send and receive SMS through your mailbox.

Powered by Outblaze
