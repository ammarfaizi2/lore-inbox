Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129711AbQKRVK7>; Sat, 18 Nov 2000 16:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130250AbQKRVKt>; Sat, 18 Nov 2000 16:10:49 -0500
Received: from quattro.sventech.com ([205.252.248.110]:45831 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129711AbQKRVKn>; Sat, 18 Nov 2000 16:10:43 -0500
Date: Sat, 18 Nov 2000 15:40:42 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: speaking of USB...(bug/hub.c)
Message-ID: <20001118154042.A15356@sventech.com>
In-Reply-To: <3A165556.FFA4FCB6@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3A165556.FFA4FCB6@linux.com>; from David Ford on Sat, Nov 18, 2000 at 02:09:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000, David Ford <david@linux.com> wrote:
> Here's another one for the books.  In the recent test11 series, timing
> appears to be partially broken for dev addr assignments.  If I'm lucky a
> new usb device will answer back and get all the numbers set up
> properly.  Regularly however a new device gets plugged in and I get
> several of the below without the success at the end.  I usually need to
> reboot to get my USB stuff alive again.  The below is test7.
> 
> # dmesg
> hub.c: USB new device connect on bus1/1, assigned device number 6
> usb-uhci.c: interrupt, status 2, frame# 121
> usb.c: USB device not accepting new address=6 (error=-110)
> hub.c: USB new device connect on bus1/1, assigned device number 7

Status 2 means there was an error with the transfer. This doesn't look
like a hub.c bug at all.

What kind of device is this?

Does this problem still happen with the other UHCI driver?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
