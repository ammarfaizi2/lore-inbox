Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTA2UCV>; Wed, 29 Jan 2003 15:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTA2UCV>; Wed, 29 Jan 2003 15:02:21 -0500
Received: from [81.2.122.30] ([81.2.122.30]:26888 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267204AbTA2UCT>;
	Wed, 29 Jan 2003 15:02:19 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301292012.h0TKCAAn002411@darkstar.example.net>
Subject: Re: Scaring the non-geeks (was Bootscreen)
To: b_adlakha@softhome.net (Balram Adlakha)
Date: Wed, 29 Jan 2003 20:12:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301300121.48705.b_adlakha@softhome.net> from "Balram Adlakha" at Jan 30, 2003 01:21:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > People find the PC boot intimidating (ask PC support people about
> > people who call in 'lost in the cosmos' and other such gems). Thats
> > why the PC boot has often gone graphical.
> 
> Exactly...
> So now its justified that there SHOULD be such a thing,

Possibly.

> and it SHOULD be WITHING THE KERNEL SOURCES

No.

> because so many people will be using it and we don't want so many
> patched kernels do we?

It should be within the bootloader, and the kernel should have an
option not to switch to the console until the login prompt, (I.E. use
two pages of VGA memory, and have the console initialised and being
written to, but not displayed until it either oopses, (in which case
you just toggle the bits in the VGA memory to switch to the other
page, simple enough to do), or as the last task before init is run).

> So now that there SHOULD be sucha thing, why not create a few implimentations
> of it which actually work well and put them into the sources?

For the same reason we got rid of the in kernel boot loader.  If it's
there, it'll get used, which is a bad thing.

John
