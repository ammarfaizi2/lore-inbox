Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTJRQDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJRQDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:03:30 -0400
Received: from quechua.inka.de ([193.197.184.2]:5089 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261683AbTJRQD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:03:29 -0400
Subject: software suspend / 2.6.0-test7,8
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: small linux home
Message-Id: <1066493069.815.1.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 18 Oct 2003 18:04:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

test7:
echo -n disk > /sys/power/state
I thought that would trigger the
linux kernel build in software suspend
(the one in the power management code, not the "swsusp" code). It does
something.
but I thought that would write it's data to
my swap partition, too. 

However what happends is, that it looks like
it shuts down, and then I see a screen from my bios, telling me that
suspend failed, because there is no partition to save the data to.

So I wonder: is the power management suspend to disk code meant to work
only in combination with the bios? 

With earlier kernels I had success with the swsusp code, it worked fine
without bios support. I will look at that again. Will I need to
remove the power management suspend to disk code from my config to make
the swsusp code work again ? (echo 4 > /proc/acpi/sleep does nothing, it
worked fine with earlier kernels (except vga and wlan)).

test8, compiled without PM_DISK:
swsusp works great! except x11 fullscreen mode doesn't work,
after killing xfree (debian testing) and restarting xfree
it works fine.

/sys/power/state still includes "disk" as supported method,
even though PM_DISK is not compiled in. strange.

Regards, Andreas

