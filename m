Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVBADm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVBADm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBADlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:41:53 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:16031 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261529AbVBADkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:40:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Date: Mon, 31 Jan 2005 22:40:35 -0500
User-Agent: KMail/1.7.2
Cc: Peter Osterlund <petero2@telia.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050131151549.26f437b0@localhost.localdomain>
In-Reply-To: <20050131151549.26f437b0@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501312240.35776.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 January 2005 18:15, Pete Zaitcev wrote:
> Hello, Peter:
> 
> The keyboard seems to work now, but I stepped on a very strange condition.
> Suddenly, touchpad motions started to cause wild movements in it became
> impossible to do anything due to a focus loss (of course, I had plenty of
> modified files open :-)
> 
> The dmesg looked like this:
> 
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> 

1. Have you tried using external PS/2 mouse?
2. Have you plugged/unplugged into a port replicator?

2nd can be cured with psmouse.resetafter=3 (at least until we get
dock support in ACPI as pluggin/unplugging resets keyboard controller
and all devices without telling anyone), first one seems to be hopeless.
External device in Dells (at least in my Inspiron 8100) completely
shadows touchpad.

-- 
Dmitry
