Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266675AbUBMByj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUBMByj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:54:39 -0500
Received: from CPE-65-28-18-238.kc.rr.com ([65.28.18.238]:36518 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S266675AbUBMByh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:54:37 -0500
Message-ID: <52417.192.168.1.12.1076637281.squirrel@mail.2thebatcave.com>
Date: Thu, 12 Feb 2004 19:54:41 -0600 (CST)
Subject: getting usb mass storage to finish before running init?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to get the kernel to finish initializing usb mass storage
devices before running init?

I have a problem where I am trying to boot off usb, but the storage device
is not detected when I am trying to do fsck and mount the flash device
from my init scripts.

I can put a sleep in there but that is sloppy, and can not really be
relied apon (since technically there is no way I can know how long the
detection phase will take), and also I may be waisting time (which I don't
want to, I want a fast booting router).

I cannot poll to wait for the device to exist in /proc/partitions or in
/dev, since some routers will boot off ide and may not even have usb
devices.

I would like to hack the kernel to wait to run init until after the usb
stuff is done (although I don't really know where to start, I don't know
where the usb or init stuff is ran from), or find some clean & reliable
way of detecting when it is done (even if it doesn't need to load usb).

I was sort of hoping there was some little-known kernel option that may
help me...

Ideas?
