Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbREWDH2>; Tue, 22 May 2001 23:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262966AbREWDHS>; Tue, 22 May 2001 23:07:18 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4943 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262964AbREWDHI>; Tue, 22 May 2001 23:07:08 -0400
Date: Tue, 22 May 2001 23:07:08 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200105230307.f4N378P19951@devserv.devel.redhat.com>
To: h.verhagen@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: Oops on booting 2.4.4
In-Reply-To: <mailman.990573660.4187.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.990573660.4187.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May 23 02:46:24 localhost kernel: Process kudzu (pid: 219,
> stackpage=c7845000)
> May 23 02:46:24 localhost kernel: Stack: c12607e0 00000400 00000400
> c73aa000 c122a060 c122a05c c122a058 c88fbb20
> May 23 02:46:24 localhost kernel:        000003f1 000003f1 c014ab80
> c73aa3f1 c7845f9c 00000000 00000400 ffffffea
> May 23 02:46:24 localhost kernel:        c7f43f60 00000400 bffff4b8
> c7f2e220 c12607e0 00000000 00000000 c73aa000
> May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>]
> [proc_file_read+184/464] [sys_read+142/196] [system_call+51/56]
> May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>] [<c014ab80>]
> [<c012e83e>] [<c0106aeb>]

A module deregistered incorrectly, or has a race between
post-load activities and unload. One way or another it left
a dangling proc entry.

The oops does not provide off-stack information, so it's impossible
to tell what particular modules is the culprit.

> May 23 02:46:24 localhost kernel: hub.c: USB new device connect on
> bus1/2, assigned device number 2
> May 23 02:46:24 localhost kernel: usb.c: USB device 2 (vend/prod
> 0x4a9/0x2204) is not claimed by any active driver.

What is this thing you have on USB? Try to run without it.

-- Pete
