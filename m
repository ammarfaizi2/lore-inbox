Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269282AbUINMCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269282AbUINMCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269300AbUINMBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:01:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4517 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269282AbUINL64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:58:56 -0400
Date: Tue, 14 Sep 2004 14:00:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [patch] sched, tty: fix scheduling latencies in tty_io.c
Message-ID: <20040914120016.GA5422@elte.hu>
References: <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <1095159217.16572.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095159217.16572.29.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2004-09-14 at 12:06, Ingo Molnar wrote:
> > the attached patch fixes long scheduling latencies in tty_read() and 
> > tty_write() caused by the BKL.
> 
> Have you verified that none of the ldisc methods rely on the big
> kernel lock. In doing the tty audit I found several cases that tty
> drivers still rely on this lock so I am curious why you make this
> change.
> 
> Would it not be better to fix the tty layer locking rather than
> introduces new random memory corruptors ?

sure ... any volunteers?

	Ingo
