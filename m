Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUGZFZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUGZFZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 01:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUGZFZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 01:25:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:39336 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264265AbUGZFZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 01:25:05 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Future devfs plans
Date: Mon, 26 Jul 2004 07:35:50 +0200
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2004.07.26.05.35.49.669188@dungeon.inka.de>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <410450CA.9080708@hispalinux.es>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004 00:34:51 +0000, Ramón Rey Vicente wrote:
> With udev you can do that, and without important bugs :). And the more
> important thing is _udev is in active development_

devfs has the "open /dev/somefile" to load $somedriver
mechanism. it is said to be racy, as far as I know.

udev works very differently. mostly, the idea is kernel detects hardware,
kernel calls hotplug, hotplug loads driver, driver registers device
structure in kernel, kernel calls hotplug for the new device, udev creates
the device in /dev.

with this mechanism, the kernel always has all drivers for hardware
currently available loaded, and udev provides the /dev devices.

devfs allowes you to not have the driver loaded till you try to use it.
so udev _cannot_ do what devfs does.

still I agree that the way kernel/hotplug/udev work is much better and
supporting the old style devfs works is not necessary. but please be
honest about the differences.

Andreas

