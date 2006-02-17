Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWBQXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWBQXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWBQXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:40:58 -0500
Received: from rtr.ca ([64.26.128.89]:49316 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751483AbWBQXk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:40:58 -0500
Message-ID: <43F65F03.1080001@rtr.ca>
Date: Fri, 17 Feb 2006 18:40:51 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: TKIP: replay detected:  WTF?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately I've been seeing my kernel logs spammed by these events:

Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000001
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000002
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000003
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000004
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000005
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000006
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000007
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000008
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000009
Feb 17 18:38:48 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 00000000000a
Feb 17 18:38:54 localhost kernel: printk: 1 messages suppressed.
Feb 17 18:38:54 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 00000000000c
Feb 17 18:38:58 localhost kernel: printk: 2 messages suppressed.
Feb 17 18:38:58 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 00000000000f
Feb 17 18:39:07 localhost kernel: printk: 2 messages suppressed.
Feb 17 18:39:07 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000012
Feb 17 18:39:08 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000013
Feb 17 18:39:25 localhost kernel: printk: 1 messages suppressed.
Feb 17 18:39:25 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000015
Feb 17 18:39:26 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000016
Feb 17 18:39:27 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000017
Feb 17 18:39:35 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000018
Feb 17 18:39:36 localhost kernel: TKIP: replay detected: STA=00:13:46:16:96:b8 previous TSC ffff80723500 received TSC 000000000019

This is with the various 2.6.16-rc*-git* kernels, and possibly older 2.6.15 series as well.
They always seem to arrive in large bursts, like the bunch shown above.  Using wifi
over ipw2200 to a WPA2 AP.

Either this is "normal" behaviour, in which case the code should NOT be spamming me,
or something is broken, in which case.. what?

Cheers
