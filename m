Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277301AbRJEDZM>; Thu, 4 Oct 2001 23:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277302AbRJEDZD>; Thu, 4 Oct 2001 23:25:03 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:53913
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S277301AbRJEDYw>; Thu, 4 Oct 2001 23:24:52 -0400
Date: Fri, 05 Oct 2001 11:27:04 +0800 (SGT)
From: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Subject: kernel: svc: bad direction / kernel: svc: short len 4, dropping request
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: gregory.hosler@eno.ericsson.se
Message-id: <XFMail.011005112704.gregory.hosler@eno.ericsson.se>
Organization: Ericsson Telecommunications, Pte Ltd
MIME-version: 1.0
X-Mailer: XFMail 1.3 [p0] on Linux
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8bit
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Linux kernel 2.4.7, and I'm seeing the following in my syslog:

Oct  5 09:13:44 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:45 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:46 camelot kernel: svc: bad direction 525795537, dropping request
Oct  5 09:13:46 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:47 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:48 camelot kernel: svc: bad direction 525861077, dropping request
Oct  5 09:13:48 camelot kernel: svc: bad direction 525927291, dropping request
Oct  5 09:13:48 camelot kernel: svc: bad direction 525992033, dropping request
Oct  5 09:13:48 camelot kernel: svc: bad direction 526057939, dropping request
Oct  5 09:13:48 camelot kernel: svc: bad direction 526123899, dropping request
Oct  5 09:13:48 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:49 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:49 camelot kernel: svc: bad direction 526189001, dropping request
Oct  5 09:13:50 camelot kernel: svc: short len 4, dropping request
Oct  5 09:13:50 camelot kernel: svc: bad direction 526254179, dropping request

several (3 to 5) messages per second.

I have tracked down these messages to coming out of:

        /usr/src/linux/net/sunrpc/svc.c

but I do not understand what's triggering them, or what to do about them.

any suggestions, pointers, hints appreciated.

thank you, and regards,

-Greg

----------------------------------
E-Mail: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Date: 05-Oct-01
Time: 11:23:35

   You can release software that's good, software that's inexpensive, or
   software that's available on time.  You can usually release software
   that has 2 of these 3 attributes -- but not all 3.

----------------------------------
