Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVKPOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVKPOEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVKPOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:04:24 -0500
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:39871
	"EHLO mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org
	with ESMTP id S1030339AbVKPOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:04:23 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <437B3C62.2090803@eyal.emu.id.au>
Date: Thu, 17 Nov 2005 01:04:18 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: hware clock left bad after a system failure
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently had two cases where my machine locked up and needed
a hard reset. The last time magic SysRq did not respond at all.

In these cases I found that the hware clock was set incorrectly
and the machine comes up with a bad date. It seems that the clock
is ahead by as much as my TZ (+10 in my case). I may be able
to understand if it was set 10h behind (kernel set it to UTC)
but this is the other way. The machine comes up with UTC+20.

Now this is just trouble. The machine comes up and spends 15m
fscking. I then reset the clock and reboot and it does the whole
fsck again because it thinks the fs was not checked for eons. It
does not understand time in the future.

So the points are

- why is the clock mangled in this way?
- should e2fsck not allow future check time (maybe within some
  limits)?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
