Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132149AbRAKL52>; Thu, 11 Jan 2001 06:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbRAKL5S>; Thu, 11 Jan 2001 06:57:18 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:8640 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131979AbRAKL5H>; Thu, 11 Jan 2001 06:57:07 -0500
Message-ID: <3A5DA113.DC8DB21C@uow.edu.au>
Date: Thu, 11 Jan 2001 23:03:31 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Troels Walsted Hansen <troels@thule.no>
CC: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, joey@linux.de,
        David Hinds <dhinds@sonic.net>
Subject: Re: [PATCH] klogd busy loop on zero byte (output from 3c59x driver)
In-Reply-To: <CKECLHEEHJOPHGPCOCKPEECCCCAA.troels@thule.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troels Walsted Hansen wrote:
> 
> Hi all.
> 
> I found a bug in the sysklogd package version 1.4. When it encounters a zero
> byte in the kernel logging output, the text parser enters a busy loop. I
> came upon it when the 3c59x driver from kernel 2.4.0 started outputting two
> zero bytes for the product code of my laptop's 3Com card. It could be argued
> that the kernel should never output zero bytes in the logging info, but
> obviously that will happen from time to time.

Yep.  %02x%02x it now is.

The code in question was snitched from pcmcia-cs's 3c575_cb.c, and
I assume David would have heard if it was busting klogd.  Maybe
there's a klogd version problem, or maybe your NIC's EEPROM is hosed?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
