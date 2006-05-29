Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWE2HwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWE2HwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWE2HwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:52:20 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:43206 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750754AbWE2HwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:52:19 -0400
Message-ID: <00cb01c682f4$c307d7a0$1800a8c0@dcccs>
From: =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to send a break?
Date: Mon, 29 May 2006 09:51:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"H. Peter Anvin" <hpa@zytor.com> az alábbiakat írta a következo üzenetben
news:e5dacu$v33$1@terminus.zytor.com...
> Followup to:  <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
> By author:    =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
> In newsgroup: linux.dev.kernel
> >
> > Hello, list,
> >
> > I wish to know, how to send a "BREAK" to trigger the sysreq functions on
the
> > serial line, using echo.
> >
> > I mean like this:
> >
> > #!/bin/bash
> > echo "?BREAK?" >/dev/ttyS0
> > sleep 2
> > echo "m" >/dev/ttyS0
> >
>
> You can't use it using echo, however, you can do it using Perl:
>
> perl -e 'use POSIX; tcsendbreak(1,0);' > /dev/ttyS0

Ahh, thats what i am waiting for, thanks! :-)

Works fine!

Thanks,
Janos




>
> -hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

