Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUBIRlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUBIRll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:41:41 -0500
Received: from medusa.csi-inc.com ([204.17.222.19]:53376 "EHLO
	medusa.csi-inc.com") by vger.kernel.org with ESMTP id S265275AbUBIRli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:41:38 -0500
Message-ID: <0a3901c3ef33$f7b52400$c8de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Andries Brouwer" <aebr@win.tue.nl>, "Alex Davis" <alex14641@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20040206212205.46151.qmail@web40501.mail.yahoo.com> <20040206223708.A2992@pclin040.win.tue.nl>
Subject: Re: Issues with linux-2.6.2
Date: Mon, 9 Feb 2004 12:41:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what's the fix?
I'm trying to recompile util-linux-2.12 on Linux 2.6.2 and getting the same error as Alex.
I'm using linux-libc-headers-2.6.1.3 -- but they don't bother to say how to install them (and I assume they will work for Linux
2.6.2).
And all this is to try and get rid of the "mount version older than kernel" message.

I suppose there's a jolly good reason for splitting the headers but it seems to just present more opportunity to hork things up.

----- Original Message ----- 
From: "Andries Brouwer" <aebr@win.tue.nl>
To: "Alex Davis" <alex14641@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, February 06, 2004 4:37 PM
Subject: Re: Issues with linux-2.6.2


> On Fri, Feb 06, 2004 at 01:22:05PM -0800, Alex Davis wrote:
>
> > I have a few issues with 2.6.2. Ths first issue is when upgrading from 2.4, I had to create
> > the symlinks:
> >
> >    ln -s /usr/include/asm /usr/src/linux/include/asm-i386
> >    ln -s /usr/include/asm-generic /usr/src/linux/include/asm-generic
> >
> > This requirement was not mentioned in any documentation I could find.
>
> No, because it is wrong. A very unwise thing to do.
>
> > The second issue is when trying to build util-linux-2.11z I get the following error:
> >
> > cc -pipe -O2 -mcpu=i486 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes
> > -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0   -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\"
> > -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\"
> > -DLOCALEDIR=\"/usr/share/locale\" -O2  -s  blockdev.c   -o blockdev
> > blockdev.c:70: error: parse error before '[' token
> > blockdev.c:70: error: initializer element is not constant
>
> And this is your punishment.
>
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

