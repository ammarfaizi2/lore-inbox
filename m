Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUK2GZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUK2GZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 01:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUK2GZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 01:25:21 -0500
Received: from mf2.realtek.com.tw ([220.128.56.22]:30481 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S261168AbUK2GZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 01:25:11 -0500
Message-ID: <007101c4d5dc$29cb0970$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <011501c4d14e$d00b1ce0$8b1a13ac@realtek.com.tw> <20041123150738.0e243724.akpm@osdl.org>
Subject: Re: I cannot stop execution by using "ctrl+c"
Date: Mon, 29 Nov 2004 14:25:04 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/11/29 =?Bog5?B?pFWkyCAwMjoyNjoyNQ==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/11/29
 =?Bog5?B?pFWkyCAwMjoyNjoyNg==?=,
	Serialize complete at 2004/11/29 =?Bog5?B?pFWkyCAwMjoyNjoyNg==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,
I had tried to disable serial drivers and it still didn't work.

The platform is the malta board with MIPS CPU.
I also tried to use newer kernel 2.6.10-rc2-mipscvs and the problem still
exists.

Thanks and regards,
Colin


----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 24, 2004 7:07 AM
Subject: Re: I cannot stop execution by using "ctrl+c"


> "colin" <colin@realtek.com.tw> wrote:
> >
> > When using gdb to debug Linux kernel, I found that it cannot be stopped
> > temporarily by using "ctrl+c".
> > After the first strike of "ctrl+c", nothing happen.
> > After the second, Linux kernel will show these messages:
> >     Interrupted while waiting for the program.
> >     Give up (and stop debugging it)? (y or n)
> > If choose yes, kernel will totally stop and it goes back to gdb shell.
> > How can I stop kernel temporarily and then resume it?
>
> This means that the kgdb stub is no longer intercepting the serial
> interrupts.  This tends to happen when someone makes changes to the serial
> layer and the kgdb patch isn't updated to reflect those changes.
>
> You failed to mention the kernel version.  The kgdb stub in 2.6.10-rc2-mm3
> should work OK.
>
> Sometimes, disabling the serial drivers in .config will help.

