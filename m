Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbTHaHxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 03:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbTHaHxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 03:53:00 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:26641 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261897AbTHaHw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 03:52:58 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.6.0-test4: Tested the Power Management Update
Date: Sun, 31 Aug 2003 15:52:20 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200308311027.08779.mhf@linuxmail.org>
In-Reply-To: <200308311027.08779.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308311551.04559.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 August 2003 10:34, Michael Frank wrote:
> 6) MINOR UNCHANGED: As to the mouse, i8042 does not resume, so I
> config i8042 as a module and reload it on resume. However, current
> drivers/input/serio/Kconfig makes this impossible, which I whined
> about a few times already ;)
>
> config SERIO_I8042
> tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
>
> Maybe bug in kconfig: Even when X86 if off, can't touch i8042
> using menuconfig.

No, just another BUG in my head: I mistook X86_GENERIC for X86
- How BRILLIANT to _hide_ X86 away in arch/i386/Kconfig - it 
is even inaccessible ....

mainmenu "Linux Kernel Configuration"

  config X86
	bool
	default y
	help
	  This is Linux's home port.  Linux was originally native to the Intel
	  386, and runs on all the later x86 processors including the Intel
	  486, 586, Pentiums, and various instruction-set-compatible chips by
	  AMD, Cyrix, and others.

Couldn't one have a better way of handling this ?

Regards
Michael

