Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVCHQ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVCHQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVCHQ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:26:59 -0500
Received: from alog0371.analogic.com ([208.224.222.147]:26496 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261349AbVCHQ06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:26:58 -0500
Date: Tue, 8 Mar 2005 11:25:13 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Joerg Pommnitz <pommnitz@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: select(2), usbserial, tty's and disconnect
In-Reply-To: <20050308161935.84907.qmail@web51405.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503081121410.11635@chaos.analogic.com>
References: <20050308161935.84907.qmail@web51405.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Joerg Pommnitz wrote:

> Hello all,
> currently it seems that select keeps blocking when the USB device behind
> ttyUSBx gets unplugged. My understanding is, that select should return
> when the next call to one of the operations (read/write) will not block.
> This is certainly true for failing with ENODEV. So, is this an issue
> that will be fixed or should I poll (not the syscall) the device? Or is
> there another way to monitor for a vanishing tty (it should not be USB
> specific).
>
> Thanks in advance
>  Joerg

In principle, you need to set your device handle (socket or fd)
to non-blocking before you use select() or poll(). It was never
resolved if the current behavior is a BUG. Nevertheless, it
is unlikely that it will be fixed because there is the belief
that it is NOT a BUG and even if it is a BUG, programs depend
upon this BUG to work.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
