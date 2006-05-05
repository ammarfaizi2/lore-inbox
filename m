Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWEEWAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWEEWAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWEEWAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:00:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:27932 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751227AbWEEWAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:00:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sVQa7CpS0llXqar4RnV0FJ52vI3+RR3Kl9Pqk7e1x8ZpiBnezR9IT6meKAzGniHRhNoLygjD4b5r6Z5LZkxD084Gbd08iHqXMGhBd4wHjxYf2W2+mn2zq6++fL33T/hMalzasXtd2Y1SC3oLkt0F/5mH4dOGmLbaLmRyMQtsBEY=
Message-ID: <445BCB8F.2070908@gmail.com>
Date: Sat, 06 May 2006 01:02:55 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: John Coffman <johninsd@san.rr.com>
CC: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       tony.luck@intel.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking   the
 256 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com> <445B610A.7020009@gmail.com> <445B62AC.90600@zytor.com> <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com> <445B96D2.9070301@zytor.com> <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com>
In-Reply-To: <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Coffman wrote:
> Just re-compiling LILO with the  COMMAND_LINE_SIZE  parameter changed
> from 256 to 512 will not work.  A .bss area must be moved to avoid
> clobbering the kernel header.

Hello John,

The COMMAND_LINE_SIZE should be fixed 256 bytes for boot
protocol < 2.02.

For boot protocol >= 2.02 it can be null terminated 256 and up.

>From LILO code I can see that COMMAND_LINE_SIZE is defined
in lilo.h, so I don't understand how a change in the
COMMAND_LINE_SIZE of the kernel affect LILO.

What we want to achieve is a kernel capable of accepting
command line size greater than 256 bytes... It is OK if LILO
will still pass 256 byte buffer as it already does.

Can you think of a reason why LILO will not work if we do
that? (lilo.h keeps #define COMMAND_LINE_SIZE 256).

Best Regards,
Alon Bar-Lev.
