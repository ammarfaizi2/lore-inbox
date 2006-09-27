Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWI0Hz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWI0Hz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWI0Hz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:55:58 -0400
Received: from www1.cdi.cz ([194.213.194.49]:21988 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S932195AbWI0Hz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:55:57 -0400
Message-ID: <451A2E83.5000806@cdi.cz>
Date: Wed, 27 Sep 2006 09:55:47 +0200
From: Martin Devera <devik@cdi.cz>
User-Agent: Thunderbird 1.5.0.5 (X11/20060729)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: stat of /proc fails after CPU hot-unplug with EOVERFLOW in 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 2way Opteron machine. I've done this:
echo 0 > /sys/devices/system/cpu/cpu1/online

and then strace stat /proc:

[snip]
personality(PER_LINUX)                  = 4194304
getpid()                                = 14926
brk(0)                                  = 0x804b000
brk(0x804b1a0)                          = 0x804b1a0
brk(0x804c000)                          = 0x804c000
stat("/proc", 0xbf8e7490)               = -1 EOVERFLOW

When I do echo 1 > ... to start cpu again then the stat starts
to work again ... Weird.

Martin
