Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRGFNkb>; Fri, 6 Jul 2001 09:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266697AbRGFNkV>; Fri, 6 Jul 2001 09:40:21 -0400
Received: from juicer35.bigpond.com ([139.134.6.87]:28926 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S266696AbRGFNkI>; Fri, 6 Jul 2001 09:40:08 -0400
Message-ID: <3B45BFE7.E27366B6@bigpond.com>
Date: Fri, 06 Jul 2001 23:40:55 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac24 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.6-ac1 parport_pc broken
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Going from 2.4.5-ac24 to 2.4.6-ac1 drivers/parport/parport_pc.c fails
depmod with unresolved symbols

Diff for the two versions is:
2831d2830
< #if defined(CONFIG_PNPBIOS)  || defined(CONFIG_PNPBIOS_MODULE)
2838d2836
< #endif

I don't have either of these set, so the bracketed code gets dropped, so
the compiler complains:
parport_pc.c: In function `parport_pc_find_ports':
parport_pc.c:2832: warning: implicit declaration of function
`pnpbios_find_device'
parport_pc.c:2832: warning: assignment makes pointer from integer
without a cast
parport_pc.c:2833: warning: implicit declaration of function
`init_pnp040x'
parport_pc.c:2835: warning: assignment makes pointer from integer
without a cast
