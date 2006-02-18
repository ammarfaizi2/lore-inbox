Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWBRLmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWBRLmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 06:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBRLmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 06:42:07 -0500
Received: from mail.gmx.de ([213.165.64.20]:2467 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751110AbWBRLmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 06:42:01 -0500
X-Authenticated: #31060655
Message-ID: <43F70807.9020504@gmx.net>
Date: Sat, 18 Feb 2006 12:41:59 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Intermittent 5-second stalls during boot on AMD64
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during boot, my AMD64 machine repeatedly stalls for a few seconds
(no sysrq possible), then it proceeds normally until the next
stall. After the stall, it begins to handle the events during the
stall, so any sysrq will be handled once the stall is over.
I have the suspicion that this has to do with SATA as the stalls
happen during times of high disk activity, sometimes also after
boot.

Are there any tricks to get a backtrace during these stalls?
Softlockup watchdog? NMI watchdog? The stalls usually take less
than 10 seconds, so I'd probably have to modify the timeouts as
well. Will the machine continue to work even after one of the
watchdogs has triggered?

Any help is appreciated.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
