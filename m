Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUGGSJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUGGSJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUGGSJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:09:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13189 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265268AbUGGSJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:09:49 -0400
Date: Wed, 7 Jul 2004 14:09:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?so=20usp?= <so_usp@yahoo.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: difference between ports
In-Reply-To: <20040707171452.9714.qmail@web53201.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0407071354160.19059@chaos>
References: <20040707171452.9714.qmail@web53201.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, [iso-8859-1] so usp wrote:

> Hi,
>
> I would like to know if there are any difference
> between I/O ports such as serial port, parallel port,
> keyboard and ide from those ones used by network
> interface, such as ssh, ftp, http and telnet. Both can
> be accessed by check_region(), request_region() and
> release_region() functions? If not, what functions can
> be used to access those ports in kernel mode?
>
> Thanks

The word 'port' can mean anything from a place where one
docks ships to some other kinds of 'terminals'.

In the nomenclature of input and output connections, we
use the term 'port' for some network addressing component
as well as some hardware addressing component. These are
not related. Also so-called "serial ports" and "parallel
ports" are not related either. They just mean "connection".
It is best to think of a port as a "thing". In other words
it has so many meanings that you need to have more information
to complete the indentity.

A I/O port to which you refer is something that is unique
to Intel CPU architecture. You can connect hardware to
so-called "ports" (addresses) where you can access it with
"in" and "out" instructions. Other architectures address
hardware using "read" and "write" instructions (with slightly
different wording) just as though the hardware was a section
of memory. Intel machines also provide this mechanism and, in
so doing, it's called "memory-mapped I/O".

The network port is a number used as a kind of sub-address.
For instance, you will receive this email on port 25, regardless
of your email address.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


