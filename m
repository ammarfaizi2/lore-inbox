Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbULBK00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbULBK00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULBK00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:26:26 -0500
Received: from gprs214-75.eurotel.cz ([160.218.214.75]:51072 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261535AbULBK0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:26:18 -0500
Date: Thu, 2 Dec 2004 11:25:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: Andrew Morton <akpm@osdl.org>, zadiglist@zadig.ca,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-ID: <20041202102556.GA1014@elf.ucw.cz>
References: <E1CZmgM-0000Lb-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CZmgM-0000Lb-00@penngrove.fdns.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I can't say i've made much more progress on the Sony VAIO latop either.
> The problem i reported earlier here can be worked around by 'rmmob'ing
> 'snd_intel8x0' before attempting a software suspend, but that hack wasn't
> much improvement.  It still crashes fairly reproducibly if left idle for
> awhile and then one/it attempts a software suspend.  The symptoms appear to
> be recursive page faults.  A second crash involving software suspend
> looks

Well, this one has taint from forced module load... If you can
reproduce it without that, it would be nice to decrease number of
modules in use, perhaps one of them is a problem?

> like it might be 'UART' related, but i'm not sure if i can reproduce that
> one easily (as i'm not running that kernel).  Both are attached
> below.

The second is oops in uart resume code, I guess some serial person
needs to debug this one.

> Aside from software suspend, the other issue is that the firewire device
> (DVD/CD-RW) does not work after software suspend.  I can document thst one
> also if it's not already a well-known problem.

Well, for me external firewire disk does not even work *before*
suspend, so... :-). [I get something like 10KB/sec transfer rate,
which means unusable disk.]
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
