Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWGWDVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWGWDVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 23:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWGWDVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 23:21:47 -0400
Received: from rialto-h50.host.net ([64.135.31.50]:12498 "EHLO
	mail.ultrawaves.com") by vger.kernel.org with ESMTP
	id S1750717AbWGWDVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 23:21:46 -0400
Message-ID: <44C2EB45.1050302@lammerts.org>
Date: Sat, 22 Jul 2006 23:21:41 -0400
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, soekris-tech@lists.soekris.com
Subject: Re: [RFC][PATCH] LED Class support for Soekris net48xx
References: <44AF7B00.9060108@bootc.net>
In-Reply-To: <44AF7B00.9060108@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> I'd love to find a way of detecting a Soekris net48xx device
 > but there is no DMI or any Soekris-specific PCI devices.

You could do ugly things like this:

         int i;
         char *bios = __va(0xf0000);

         for(i = 0; i < 0x10000 - 19; i++) {
                 if(memcmp(bios + i, "Soekris Engineering", 19) == 0) {
                         printk("soekris string found at 0x%x\n", i);
                 }
         }

The string "net4801" is also in there (although I'm using a 4826).

If anyone knows a better way, I'd like to know it too.

Eric
