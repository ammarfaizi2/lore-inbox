Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWA3WEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWA3WEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWA3WEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:04:24 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:20753 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S932334AbWA3WEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:04:24 -0500
Message-ID: <43DE8D5E.2040905@rulez.cz>
Date: Mon, 30 Jan 2006 23:04:14 +0100
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: udevstart surprisingly slow
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I've recently upgraded udev from 063 to 082 and then 084.

With 063, startup of udev was near-instant; with both 082 and 084, it 
takes a significant ammount of time (~15s) to create the base devices 
using udevstart or udevsynthesize (this one is taken from Debian, which 
apparently in turn taken it from SuSE; the rest of codebase is vanilla).

This issue appears on kernel 2.6.15.1 with SquashFS 2.2r2, SWSUP2 2.2 
and VesaFB-TNG 1.0-rc1-r3 patches.

The init script used simply mounts 10MiB tmpfs onto /dev, creates 
/dev/.udev/{db,queue} directories, then runs udevd --daemon and then 
udevsynthesize or udevstart (tried both, same result).

I'm quite out of ideas, I don't think downgrading udev is the best 
solution, so I wonder: what takes such a long time in udevstart? What 
can I alter at my end, or is this a known bug (or feature)?

Thanks in advance for reply
  -- iSteve
