Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSGCQwb>; Wed, 3 Jul 2002 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSGCQvy>; Wed, 3 Jul 2002 12:51:54 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:57565 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317253AbSGCQvo>; Wed, 3 Jul 2002 12:51:44 -0400
Date: Wed, 3 Jul 2002 05:48:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020703034809.GI474@elf.ucw.cz>
References: <20020702123718.A4711@redhat.com> <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Okay. So we want modules and want them unload. And we want it bugfree.

So... then its okay if module unload is *slow*, right?

I believe you can just freeze_processes(), unload module [now its
safe, you *know* noone is using that module, because all processes are
in your refrigerator], thaw_processes().

That's going to take *lot* of time, but should be very simple and very
effective.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
