Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVAaXQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVAaXQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVAaXQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:16:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261430AbVAaXQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:16:24 -0500
Date: Mon, 31 Jan 2005 15:15:49 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Peter Osterlund <petero2@telia.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050131151549.26f437b0@localhost.localdomain>
In-Reply-To: <m3acqr895h.fsf@telia.com>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter:

The keyboard seems to work now, but I stepped on a very strange condition.
Suddenly, touchpad motions started to cause wild movements in it became
impossible to do anything due to a focus loss (of course, I had plenty of
modified files open :-)

The dmesg looked like this:

psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.

Now I'm afraid to run that kernel again (2.6.11-rc2 + your patches
1/4 and 2/4).

I run that kernel with hardware tap disabled (tap_time = 0).

-- Pete
