Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUJDJH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUJDJH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 05:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUJDJH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 05:07:58 -0400
Received: from dialpool2-139.dial.tijd.com ([62.112.11.139]:6016 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S267856AbUJDJHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 05:07:50 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.9-rc3] suspend-to-disk oddities
Date: Mon, 4 Oct 2004 11:07:11 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041107.12049.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

Just tried swsusp, works great, besides a few strange things:

- The suspend routine is unable to shutdown the mysqld process:

Oct  4 10:19:43 precious kernel: Stopping tasks: =================================================
Oct  4 10:19:43 precious kernel:  stopping tasks failed (1 tasks remaining)
Oct  4 10:19:43 precious kernel: Restarting tasks...<6> Strange, mysqld not stopped
Oct  4 10:19:43 precious kernel:  done

- USB subsystem is totally unworking until I reinitialise it (using /etc/init.d/hotplug restart)
- modem does not work (uses ALSA module snd_intel8x0m with a 'modem daemon'). Restarting the daemon makes things work.
- ALSA mixer volume is set to 0 for all channels (can be fixed by running /etc/init.d/alsa start at resume)

Otherwise than these small problems it works fine, from within X. Using the radeon driver.

Jan
-- 
Beauty and harmony are as necessary to you as the very breath of life.
