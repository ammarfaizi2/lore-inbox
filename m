Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbQKUKpe>; Tue, 21 Nov 2000 05:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129882AbQKUKpY>; Tue, 21 Nov 2000 05:45:24 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:27123 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129855AbQKUKpM>;
	Tue, 21 Nov 2000 05:45:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001120121746.F895@valinux.com> 
In-Reply-To: <20001120121746.F895@valinux.com>  <20001117125441.A28208@iXcelerator.com> 
To: Johannes Erdfelt <jerdfelt@valinux.com>
Cc: Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2000 10:13:19 +0000
Message-ID: <1891.974801599@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jerdfelt@valinux.com said:
>  We applied a slightly different patch which is would not remove the
> pages out from under the thread, using semaphores instead.

> This patch isn't needed anymore. Thanks anyway.

Actually, the best fix is probably to get rid of the thread entirely and use
schedule_task to run usb_hub_events() instead.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
