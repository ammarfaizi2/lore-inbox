Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUINM27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUINM27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUINM1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:27:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27059 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269416AbUINM0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:26:24 -0400
Date: Tue, 14 Sep 2004 14:27:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [patch] sched, tty: fix scheduling latencies in tty_io.c
Message-ID: <20040914122748.GA6846@elte.hu>
References: <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <1095159217.16572.29.camel@localhost.localdomain> <20040914120016.GA5422@elte.hu> <1095160687.16572.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095160687.16572.34.camel@localhost.localdomain>
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

> On Maw, 2004-09-14 at 13:00, Ingo Molnar wrote:
> > > Would it not be better to fix the tty layer locking rather than
> > > introduces new random memory corruptors ?
> > 
> > sure ... any volunteers?
> 
> Not that I've seen. I'm fixing some locking but not stuff that depends
> on lock_kernel(). [...]

would it be a sufficient fix to grab some sort of tty_sem mutex in the
places where the patch drops the BKL - or are there other entry paths to
this code?

	Ingo
