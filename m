Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQKOAMS>; Tue, 14 Nov 2000 19:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbQKOAMI>; Tue, 14 Nov 2000 19:12:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:57615 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129170AbQKOALs>;
	Tue, 14 Nov 2000 19:11:48 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Timur Tabi <ttabi@interactivesi.com>
cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "couldn't find the kernel version the module was compiled for" - help! 
In-Reply-To: Your message of "Tue, 14 Nov 2000 17:35:37 MDT."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Nov 2000 10:41:42 +1100
Message-ID: <12388.974245302@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000 17:35:37 -0600, 
Timur Tabi <ttabi@interactivesi.com> wrote:
>Ok, I made this change:
>
>#ifndef __ENTRY_C__
>#define __NO_VERSION__
>#endif
>#include <linux/version.h>
>
>and in entry.c:
>
>#define __ENTRY_C__
>#include "include.h"
>
>Unfortunately, it still doesn't work.

__NO_VERSION__ must be defined before #include <module.h>.  Do it by hand.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
