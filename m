Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKAJuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKAJuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVKAJuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:50:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29066 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750701AbVKAJuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:50:04 -0500
Date: Tue, 1 Nov 2005 10:49:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu
Subject: after latest input updates, locomo keyboard kills boot
Message-ID: <20051101094945.GA7293@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

drivers/input/keyboard/locomokbd.c:

struct locomokbd {
        unsigned char keycode[LOCOMOKBD_NUMKEYS];
        struct input_dev input;
	~~~~~~~~~~~~~~~~~~~~~~~

...and I guess that's the problem. What needs to be done? Just replace
it with struct input_dev *?

								Pavel
-- 
Thanks, Sharp!
