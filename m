Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288922AbSBDLkw>; Mon, 4 Feb 2002 06:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSBDLkl>; Mon, 4 Feb 2002 06:40:41 -0500
Received: from [199.203.178.211] ([199.203.178.211]:27400 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S288922AbSBDLkc>; Mon, 4 Feb 2002 06:40:32 -0500
Message-ID: <BDE817654148D51189AC00306E063AAE054623@exchange.store-age.com>
From: Alexander Sandler <ASandler@store-age.com>
To: "'sathish jayapalan'" <sathish_jayapalan@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: RE: How to crash a system and take a dump?
Date: Mon, 4 Feb 2002 13:40:07 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="x-user-defined"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I have a doubt. I know that linux kernel doesn't crash
> so easily. Is there any way to panic the system? Can I
> go to the source area and insert/modify a variable in
> kernel code so that the kernel references a null
> pointer and crashes while running the kernel compiled
> with this variable. My aim is to learn crash dump
> analysis with 'Lcrash tool". Please help me out with
> this.

Go to interrupt handler (for instance in fs/buffer.c end_buffer_io_async() )
and cause segmentation fault.
System will try to kill process that caused segmentation fault and since
it's in interrupt context will panic.

Sasha.
