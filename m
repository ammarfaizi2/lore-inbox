Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVEWB03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEWB03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 21:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEWB03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 21:26:29 -0400
Received: from zipcon.net ([209.221.136.5]:31463 "HELO zipcon.net")
	by vger.kernel.org with SMTP id S261739AbVEWB01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 21:26:27 -0400
Message-ID: <429130FF.2040804@beezmo.com>
Date: Sun, 22 May 2005 18:25:19 -0700
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 & 11 hang on ac/dc change
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the course of trying to figure out why /sys/.../cpu0 isn't populated
when in APM mode, I discovered that the laptop hangs on the first (?)
attempt to write to the drive after a change of power source.

This is a ThinkPad T43.  I see the problem with both 2.6.9-1.667 and
2.6.11-1.14_FC3 (both FC3).  Doesn't seem to happen in ACPI mode.
I need APM since that suspends and hibernates will on TPs. (Including
this one)

It always leads to a filesystem check on reboot, and once it damaged
the partition so badly that it wouldn't reboot and "linux rescue" from
the FC3 DVD couldn't mount it.  That time, I got "journalling error"
messages on the console, and "abnormal status 0xD0 on port 0x1F7"
when I tried to shut down.

I can't write to the HD to try to capture anything, so I don't have
much diagnostic info.  I have posted the APM boot messages, FWIW:
http://www.beezmo.com/scratch/t43_fc3/dmesg.apm

Any place I should poke to track this one down?  If this doesn't belong
on lkml, please point me appropriately.

Thanks,
Bill (not subscribed but lurking on fa.linux.kernel)
-- 

