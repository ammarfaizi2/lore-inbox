Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUETOEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUETOEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 10:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUETOEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 10:04:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64130 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265099AbUETOEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 10:04:10 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Jinu M." <jinum@esntechnologies.co.in>, <linux-kernel@vger.kernel.org>
Subject: Re: protecting source code in 2.6
Date: Thu, 20 May 2004 16:05:34 +0200
User-Agent: KMail/1.5.3
Cc: <kernelnewbies@nl.linux.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405201605.34100.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 20 of May 2004 15:18, Jinu M. wrote:
> Hi All,

Hi,

> We are developing a block device driver on linux-2.6.x kernel. We want
> to distribute our driver as sum of source code and librabry/object code.
>
> We have divided the source code into two parts. The os interface module
> and the device interface module. The os interface module (osint.c) has
> all the os interface functions (init, exit, open, close, ioctl, request
> queue handling etc). The device interface module (devint.c) on the other
> hand has all the device interface functions (initialize device, read,
> write etc), these don't use system calls or kernel APIs.
>
> The device interface module is proprietary source and we don't intend
> to distribute it with source code on GPL license.

You may want to reconsider your decision.

- by providing non-GPL driver your driver is very likely
  to not work with future kernel versions due to the fact that
  Linux driver API is not stable (it changes *very* frequently)

- nobody is going to provide support for kernels with your driver
  loaded - you have to deal with bugreports about *all* Linux kernel
  issues from users of your driver

> What we intend to do is, distribute the os interface module (osint.c)
> with
> source code and the device interface module as object code or library.
> The
> user will compile the os interface module on the target box and link it
> with the device interface module to generate the .ko (loadable module).
>
> We are not very sure of how to achieve this.
> Please help us address this issue.

Please be aware of the fact that without 'giving source back'
nobody is going to help you on kernel issues here.

Kind regards,
Bartlomiej

> Thanks in advance,
> -Jinu

