Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUHYJyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUHYJyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUHYJxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:53:03 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:38118 "EHLO
	tyo206.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266003AbUHYJwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:52:06 -0400
Message-ID: <024c01c48a89$283dd4f0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "James Morris" <jmorris@redhat.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0408240908530.19614-100000@thoron.boston.redhat.com>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Wed, 25 Aug 2004 18:51:56 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, thanks for your comment.

> > o dbench [ 4 processes run parallely on 4-CPUs / 10 times trials ]
> >                   ---- mean ----  - STD -
> > 2.6.8.1(disable)  860.249 [MB/s]   44.683
> > 2.6.8.1(enable)   714.254 [MB/s]   32.359
> > 2.6.8.1(+rwlock)  767.904 [MB/s]   27.968
> > 2.6.8.1(+RCU)     830.678 [MB/s]   16.352
> 
> Can you show the figures for 1 and 2 clients?

The results are as follows:
o dbench [ 1/2/4 processes run parallely on 4-CPUs / 10 times trials ]
- Average[MB/s] -  -1proc- -2procs- -4procs-
2.6.8.1(disable)    247.43   473.11   891.51
2.6.8.1(enable)     218.99   434.97   761.06
2.6.8.1(+rwlock)    225.18   432.80   802.62
2.6.8.1(+RCU)       231.84   444.30   820.00
--------------------------------------------
(*) 2.6.8.1(+RCU) is applied the take3-patch.

By the way, the results of dbench are sharply changed at every measurement.
I don't think it is statistically-significant.

--------
Kai Gai <kaigai@ak.jp.nec.com>

