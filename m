Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTFPOKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFPOKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:10:33 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:37786 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263865AbTFPOKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:10:31 -0400
Date: Mon, 16 Jun 2003 16:23:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: i8253 != rtc
Message-ID: <20030616142340.GA369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 /* XXX this driverfs stuff should probably go elsewhere later -john
*/
 static struct sys_device device_i8253 = {
-       .name           = "rtc",
        .id             = 0,
-       .dev    = {
-               .name   = "i8253 Real Time Clock",
-       },
+       .cls    = &rtc_sysclass,
 };

...but i8253 is *not* real time clock. Its clock since
bootup. Realtime clock is near battery-backed CMOS RAM, its driver is
linux/drivers/char/rtc.c...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
