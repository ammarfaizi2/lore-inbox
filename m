Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTKJP5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTKJP5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:57:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17794 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263926AbTKJP5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:57:06 -0500
Date: Mon, 10 Nov 2003 10:58:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall numbers larger than 255?
In-Reply-To: <3FAFB081.3090900@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0311101054430.15074@chaos>
References: <3FAFB081.3090900@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Chris Friesen wrote:

>
> Just a quick and simple question for someone that knows the answer.
>
> Stock 2.4.20 for i386 uses syscalls up to 252.  I want to add about a
> half-dozen new syscalls (forward porting stuff that we've got on 2.4.18).
>
> Does x86 support syscall numbers > 255?  If yes, do I have to do
> anything special to use them? If not, what are my options?
>
> Thanks,
>
> Chris

Sure. With the old int 0x80 calling convention, the syscall number
is just put into the EAX register which can contain 32 bits. There
may be some mask on the kernel side to limit 'damage', but you
can change this if you are adding system-calls. The newer calling
convention also has just the 32 bit limitation.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


