Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTDWMJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264011AbTDWMJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:09:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59527 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264009AbTDWMJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:09:20 -0400
Date: Wed, 23 Apr 2003 08:22:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Data storing
In-Reply-To: <200304231459.37955.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304230817340.22823@chaos>
References: <200304231459.37955.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

> Hello!
>
> I need to make some checks (search for particular BIOS version) in the
> very start of the kernel. I need to store this data (zero page is pretty good
> for this, I think) and access it from arch/i386/boot/setup.S,
> arch/i386/boot/compressed/misc.c and in some other places. Can somebody
> suggest me good place to put check procedure and how to pass data?
>
> Best regards,
> Andrew.

I use 0x000001f0 (absolute) for relocating virtual disk code
for booting embedded systems. After Linux is up, the code remains
untouched. This might be a good location because the BIOS doesn't
use it during POST/boot and Linux (currently) leaves it alone.
Of course, this doesn't mean that somebody will not destroy this
area in the future (probably to spite you and me!!!).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

