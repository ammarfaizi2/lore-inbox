Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSH0QK0>; Tue, 27 Aug 2002 12:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSH0QKZ>; Tue, 27 Aug 2002 12:10:25 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:19467 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316576AbSH0QKZ>;
	Tue, 27 Aug 2002 12:10:25 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271614.g7RGEhe27614@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: <Pine.LNX.4.44.0208271006260.3234-100000@hawkeye.luckynet.adm> from
 Thunder from the hill at "Aug 27, 2002 10:06:50 am"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Tue, 27 Aug 2002 18:14:43 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Thunder from the hill wrote:"
> Hi,
> On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> > Is there any way of turning off VMS caching for a block device?

> O_DIRECT, or easily set the buffer to zero...

Thanks!

Yes, I've noticed this in the 2.5.31 kernel. This is something
to be done on open by the overlying fs or userspace utility, or
should I set the flag on the inode->filp (or whatever) myself in
the drivers open function? And do I need to define
inode->mapping->a_ops->direct_IO()? (sorry - but I haven't had time to
experiment yet today!).

It looks like the 2.5 kernel has this pathway, but what about the 2.4
kernel? Nothing.

Peter
