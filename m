Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263988AbRFEOIc>; Tue, 5 Jun 2001 10:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263987AbRFEOIV>; Tue, 5 Jun 2001 10:08:21 -0400
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:43141 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S263986AbRFEOIM>; Tue, 5 Jun 2001 10:08:12 -0400
Message-ID: <3B1D122E.87AEF85F@adelphia.net>
Date: Tue, 05 Jun 2001 10:09:02 -0700
From: Stephen Wille Padnos <stephenwp@adelphia.net>
Organization: Thoth Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting new functions from kernel 2.2.14
In-Reply-To: <OIBBKHIAILDFLNOGGFMNOEHLCBAA.arthur.naseef@ariel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Actually, the symbols in question aren't in modules.  The kernel is module
enabled, but all drivers are being compiled in (this is for an embedded
system).  My external module (which needs to grab the timer interrupt) is in a
separate source tree.

Thanks for the printk info - I guess boneheads like me could use a FAQ that
tells which order the miscellaneoud include files need to be in.  (I had
modules.h after linux.h).  I changed the order, butI am waiting for a recompile
now, so I don't know if the reordering worked.

Arthur Naseef wrote:

...

> you can edit the .ver file yourself (under /usr/src/linux/include/modules/)
> and add entries.  This will eliminate the funny versioning, as in:
> As far as the printk() warning, you need to make sure your module code
> includes the right header files.  In this case, I believe you need to grab
> <linux/kernel.h> after including <linux/module.h>.
>
> I hope this helps.
>
> -art
>



