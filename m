Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbSLRTbc>; Wed, 18 Dec 2002 14:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbSLRTbc>; Wed, 18 Dec 2002 14:31:32 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:15531 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S267334AbSLRTba>; Wed, 18 Dec 2002 14:31:30 -0500
Date: Thu, 19 Dec 2002 08:37:30 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: RE: [ACPI] Re: [PATCH] S4bios for 2.5.52.
In-reply-to: <20021218085902.GD1012@poup.poupinou.org>
To: "'Ducrot Bruno'" <poup@poupinou.org>,
       "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>
Cc: "'Grover, Andrew'" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org,
       "'Pavel Machek'" <pavel@suse.cz>, acpi-devel@lists.sourceforge.net
Message-id: <000401c2a6cc$ec43a2f0$0101010a@NigelLaptop>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kai, if you see that S4OS is slower, it is probably a bug
> that have to be
> fixed in swsusp.

There does seem to be a problem with the rw_swap_page_sync routine. Perhaps
not on Pavel's machine (:>), but I've experienced painfully slow suspends
too. Performance was helped immensely by applying a concept that I'll credit
Lyle Seaman for - unrolling rw_swap_page_sync and submitting all the IO for
pages then looping again and waiting on each sync. I found with writing 7000
or so pages (a suspend from init S) that something gets triggered to force
the sync about every 3900 pages anyway.

Regards,

Nigel

