Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUEMBOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUEMBOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 21:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUEMBOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 21:14:46 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:42680 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261867AbUEMBOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 21:14:45 -0400
Subject: swsusp + APM in 2.6.6
From: Plaz McMan <PlazMcMan@Softhome.net>
To: linux-kernel@vger.kernel.org
Message-Id: <1084411449.2562.20.camel@ansel.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 12 May 2004 18:24:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading older IBM ThinkPad from 2.6.1 to 2.6.6.

In 2.6.1, I had ACPI + APM support compiled in, and I disabled ACPI at
boot (acpi=off). With this setup, I could sleep, shutdown, and use swap
suspend with "echo 4 > /proc/sleep" (_not_ /proc/acpi/sleep, as there
was no /proc/acpi). I slept the computer with "apm -[s,S]". I had ACPI
support because for some reason the computer wouldn't shutdown without
it, even though I have it disabled at boot. Note that ACPI wouldn't
properly sleep my computer (display stayed on, even with lid closed),
which is why I used APM. In any event, 2.6.1 worked _great_ as far as PM
stuff was concerned.

In 2.6.6, however, using the same kernel configuration, neither
/proc/sleep or /proc/acpi/sleep exist! I _do_ have swsusp enabled in the
kernel, as well as ACPI sleep states (do they do anything if you disable
ACPI at boot?). ACPI sleep doesn't turn off the screen, so I want to use
APM. However, I also want swsusp to work. So, I will continue to use
2.6.1 until everything pans out.

Other kernels (maybe only 2.6.5) wouldn't support my mobo's DMA, so I
haven't tested this out on them. I will, however, at request.

Thanks,
-Brannon Klopfer

