Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWHQO3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWHQO3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHQO3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:29:51 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:42897 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932501AbWHQO3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:29:50 -0400
Date: Thu, 17 Aug 2006 18:29:48 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: ip3106_uart oddity
Message-Id: <20060817182948.0381306c.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

it looks like drivers/serial/ip3106_uart.c was dropped from the mainline at some point I couldn't identify. Can you please confirm that?
I'd like to take the burden of restoring the UART functionality for PNX8550 boards in the mainline. This very UART HW is very weird and doesn't fit well into 8250 model, even with fixups like those that were introduced for Alchemy. It also differs from the IP_3106-based UARTs used on Philips ARM targets in registers layout so I'm not sure it's correct to call it ip3106_uart.
So, given the above, does it make sense to try make it fir into standard 8250 driver model or restore/rework the custom driver?

Thanks,
   Vitaly
