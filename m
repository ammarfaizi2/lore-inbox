Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267127AbTGOKs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267140AbTGOKs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:48:27 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:38920 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S267127AbTGOKsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:48:24 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Tue, 15 Jul 2003 18:42:17 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <20030715085622.A32119@flint.arm.linux.org.uk> <200307151734.46616.mflt1@micrologica.com.hk>
In-Reply-To: <200307151734.46616.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151842.19851.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try to trace where the interrupt dies.

I tried already an int 0x25 in yenta_init which has no effect...

BTW:

On Tuesday 15 July 2003 17:34, Michael Frank wrote:
> Jul 15 17:05:00 mhfl2 kernel: Suspending devices
> Jul 15 17:05:00 mhfl2 kernel: Yenta: dev suspend
> Jul 15 17:05:00 mhfl2 kernel: Yenta: suspend saved state ff
> Jul 15 17:05:00 mhfl2 kernel: /critical section: Counting pages to
> copy[nosave c03e2000] (pages needed: 3426+512=3938 free: 57849) Jul 15
> 17:05:00 mhfl2 kernel: Alloc pagedir
> Jul 15 17:05:00 mhfl2 kernel: ....[nosave c03e2000]Enabling SEP on CPU 0
> Jul 15 17:05:00 mhfl2 kernel: Freeing prev allocated pagedir
>
> power down - resume
>
> Jul 15 17:05:00 mhfl2 kernel: Yenta: dev resume

Dev resume ahead of socket resume?

> Jul 15 17:05:00 mhfl2 kernel: Yenta: init restored state ff
> Jul 15 17:05:00 mhfl2 kernel: Trying to free nonexistent resource
> <000003f8-000003ff> Jul 15 17:05:00 mhfl2 kernel: Yenta: init restored
> state ff
> Jul 15 17:05:00 mhfl2 kernel: hda: Wakeup request inited, waiting for
> !BSY... Jul 15 17:05:00 mhfl2 kernel: hda: start_power_step(step: 1000)
> Jul 15 17:05:00 mhfl2 kernel: hda: completing PM request, resume
> Jul 15 17:05:01 mhfl2 kernel: Devices Resumed
> Jul 15 17:05:01 mhfl2 kernel: Devices Resumed
> Jul 15 17:05:01 mhfl2 kernel: Yenta: dev resume

One more dev resume

Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

