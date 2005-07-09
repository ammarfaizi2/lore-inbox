Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVGIJCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVGIJCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 05:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVGIJCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 05:02:52 -0400
Received: from tag.witbe.net ([81.88.96.48]:1229 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261460AbVGIJCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 05:02:51 -0400
Message-Id: <200507090901.j6991PD22890@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Kristian Benoit'" <kbenoit@opersys.com>, <linux-kernel@vger.kernel.org>
Cc: <paulmck@us.ibm.com>, <bhuey@lnxw.com>, <andrea@suse.de>,
       <tglx@linutronix.de>, <karim@opersys.com>, <mingo@elte.hu>,
       <pmarques@grupopie.com>, <bruce@andrew.cmu.edu>,
       <nickpiggin@yahoo.com.au>, <ak@muc.de>, <sdietrich@mvista.com>,
       <dwalker@mvista.com>, <hch@infradead.org>, <akpm@osdl.org>,
       <rpm@xenomai.org>
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
Date: Sat, 9 Jul 2005 11:01:24 +0200
Organization: Witbe
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <42CF05BE.3070908@opersys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcWEEmNKNNT3RLi0ThOm8hxRLAgb7QAUb2pw
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> "IRQ & hd" run:
> Measurements   |   Vanilla   |  preempt_rt    |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |     101us   |   94us (-7%)   |  103us (+2%)
> open/close     |     2.9us   |  2.9us (~)     |  3.0us (+3%)
> execve         |     366us   |  370us (+1%)   |  372us (+2%)
> select 500fd   |    14.3us   | 18.1us (+27%)  | 14.5us (+1%)
> mmap           |     794us   |  654us (+18%)  |  822us (+4%)

                                  ^^^^^^^^^^^^
You mean -18%, not +18% I think.

Just having a quick long at the numbers, it seems that now the "weak"
part in PREEMPT_RT is the select 500fd test.

Ingo, any idea about this one ?

Regards,
Paul

