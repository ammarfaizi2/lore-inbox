Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263995AbRFEOcL>; Tue, 5 Jun 2001 10:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263996AbRFEOcB>; Tue, 5 Jun 2001 10:32:01 -0400
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:56223 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S263995AbRFEObv>; Tue, 5 Jun 2001 10:31:51 -0400
Message-ID: <3B1D17B9.92D046A1@adelphia.net>
Date: Tue, 05 Jun 2001 10:32:41 -0700
From: Stephen Wille Padnos <stephenwp@adelphia.net>
Organization: Thoth Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting new functions from kernel 2.2.14
In-Reply-To: <OIBBKHIAILDFLNOGGFMNOEHLCBAA.arthur.naseef@ariel.com> <3B1D122E.87AEF85F@adelphia.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, my rebuild kernel / reboot / recompile module just finished.

Unfortunately, the printk warning was still there.

I replaced the unconditional #define MODVERSIONS with
#include <linux/config.h>
#ifdef CONFIG_MODVERSIONS
#define MODVERSIONS
#include <linux/modversions.h>
#endif

this is at the top of my source file. (before module.h and linux.h)

(as seen somewhere on the web)
and it compiles without warnings now.

Now all I need is some info on module oparameters and using /proc :)

Thanks again.
- Steve


