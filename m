Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVDGW36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVDGW36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVDGW36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:29:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22153 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262180AbVDGW3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:29:22 -0400
Message-ID: <4255B43F.80606@us.ibm.com>
Date: Thu, 07 Apr 2005 15:29:19 -0700
From: Vernon Mauery <vernux@us.ibm.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: set keyboard repeat rate: EVIOCGREP and EVIOCSREP
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if anyone knows how to change the repeatrate on a USB keyboard with a 2.4 kernel.  The system is a legacy free system (no ps2 port), so kbdrate does nothing.  With evdev loaded, the keyboard and mouse (both USB devices) get registered with the event system and show up as /dev/input/event[01].  I know the event subsystem does software key repeating and was wondering how to change that.

I poked around and found the EVIOCGREP and EVIOCSREP ioctls, but when I tried using them, the ioctl returned invalid parameter.  Upon further investigation, I found that the ioctl definitions (located in the linux/input.h header file) are not used in kernel land.  That would explain why it failed, but that just means I ran into a dead end.  Were those definitions legacy code from 2.2 or is it something that never got implemented, only defined?  I also noticed that the defines are gone in 2.6.  So how _does_ one go about changing the repeat rate on a keyboard input device in 2.4?

Thanks in advance for your help.

--Vernon Mauery
