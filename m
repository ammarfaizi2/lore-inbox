Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSF0MUw>; Thu, 27 Jun 2002 08:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316799AbSF0MUw>; Thu, 27 Jun 2002 08:20:52 -0400
Received: from host37.240.113.209.conversent.net ([209.113.240.37]:45272 "EHLO
	netezza.com") by vger.kernel.org with ESMTP id <S316798AbSF0MUv>;
	Thu, 27 Jun 2002 08:20:51 -0400
From: "Amrith Kumar" <akumar@netezza.com>
To: <linux-kernel@vger.kernel.org>
Subject: Maximum core file size in Linux 
Date: Thu, 27 Jun 2002 08:30:34 -0400
Message-ID: <GMEPJBOPOAKOBODMIKMGMEMHCAAA.akumar@netezza.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appears that there's an implicit 2Gb limit on the size of core files because
it's being created without O_LARGEFILE.

A small change in fs/exec.c (do_coredump) gets me past the limit and I can
now generate a core file in excess of 2Gb but then gdb complains that the
core dump is too large ...

Looks like there's a broader underlying issue here that would involve
changes to other places than I had thought would be required.

Anyone else out there run into a similar problem ? And if so, could you let
me know what other things I may run into ... Also, is this something that
has been fixed in a forthcoming release ?

Thanks,

/a

--
Amrith Kumar
akumar@netezza.com
508-665-6835

#include <std_disclaimer.h>
This e-mail message is for the sole use of the intended recipient(s) and may
contain Netezza Corporation confidential and privileged information.  Any
unauthorized review, use, disclosure, or distribution is prohibited.  If you
are not the intended recipient, please contact the sender by reply e-mail
and destroy all copies of the original message.


