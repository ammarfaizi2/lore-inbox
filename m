Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTJNMKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTJNMKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:10:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40581 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262465AbTJNMKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:10:53 -0400
Date: Tue, 14 Oct 2003 08:12:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sebastian Piecha <spi@gmxpro.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to wait for kernel messages?
In-Reply-To: <3F8ACBEA.5414.1072DA2C@localhost>
Message-ID: <Pine.LNX.4.53.0310140804200.19781@chaos>
References: <3F8ACBEA.5414.1072DA2C@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Sebastian Piecha wrote:

> I have some problems with one NIC. Due to lack of time as an
> workaround I'd like to wait for the kernel message "NETDEV WATCHDOG:
> eth0: transmit timed out" and ifconfig down/up the NIC.
>
> How can I trigger any action by such a kernel message? Do I have to
> grep the kernel log?
>
> Mit freundlichen Gruessen/Best regards,
> Sebastian Piecha

`cat /proc/kmsg`

...or to wait forever for each message, just open /proc/kmsg and
post a read. Note that kernel logger is also waiting for such
messages so you might not get them all.

Of course the 'Unix-way' is to just do `tail -f /var/log/messages`,
or whatever your log-file name is.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


