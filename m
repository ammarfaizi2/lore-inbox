Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131515AbQKQKHJ>; Fri, 17 Nov 2000 05:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbQKQKHA>; Fri, 17 Nov 2000 05:07:00 -0500
Received: from web1106.mail.yahoo.com ([128.11.23.126]:19465 "HELO
	web1106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131485AbQKQKGs>; Fri, 17 Nov 2000 05:06:48 -0500
Message-ID: <20001117093647.10783.qmail@web1106.mail.yahoo.com>
Date: Fri, 17 Nov 2000 10:36:47 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: [2.2.18pre21] Megaraid : guessed right.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

here is what /proc/pci reports for the netraid
adapter:

 Prefetchable 32 bit memory at 0xf0000000
[0xf0000008].

So it's now clear that the base address (megaBase)
isn't always 16-bytes aligned, which explains why
my card works again with my minimal patch.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
