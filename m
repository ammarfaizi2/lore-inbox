Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUDOScc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDOS3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:29:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11268 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261875AbUDOS0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:26:32 -0400
Date: Thu, 15 Apr 2004 14:27:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Smart, James" <James.Smart@Emulex.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: persistence of kernel object attribute ??
In-Reply-To: <3356669BBE90C448AD4645C843E2BF2802C0168B@xbl.ma.emulex.com>
Message-ID: <Pine.LNX.4.53.0404151419550.5024@chaos>
References: <3356669BBE90C448AD4645C843E2BF2802C0168B@xbl.ma.emulex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Smart, James wrote:

> Yes - I was well aware of this, and considered it an "automation" of the
> user funciton.
>
> Unfortunately, this won't work, as it doesn't address the case where the
> driver is part of the boot process (e.g. it's the hba used to reach the boot
> disk). I'm looking for something that addresses this too..
>

In that case, the "registry" won't work either. If you can't
access the file-system that contains the "registry" (it's just
a corrupt file), to get the bits necessary to turn on your
controller, then you need to use a serial EEPROM or some such
as is done all the while.

Over and over again, I hear people who think that you should
be able to open a file from within the code that opens the
file (the kernel). Turns out, you now can. You can create
a task called a "kernel thread". Since it has a context, it
can open a file and read from it (not using any user-mode
interface). But this won't help you either because the
file won't exist until you configure your controller
and it gets mounted.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.


