Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSG1UMm>; Sun, 28 Jul 2002 16:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSG1UMm>; Sun, 28 Jul 2002 16:12:42 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:16652 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317305AbSG1UMl>;
	Sun, 28 Jul 2002 16:12:41 -0400
Message-ID: <3D4451C5.456EE1D2@tv-sign.ru>
Date: Mon, 29 Jul 2002 00:19:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] Thread-Local Storage (TLS) support for 
 Linux,2.5.28
References: <Pine.LNX.4.44.0207282201020.32399-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> > I thought, that gdt entry consulted only while
> > loading its index into the segment register.
> >
> > So load_TLS_desc(next, cpu) must be called before
> > loading next->fs,next->gs in __switch_to() ?
> 
> hm, right. I'm wondering, why did the tls_test code still work?
> 
>         Ingo

Because that code reloads %fs before every time in {read,write}seg.

Oleg.
