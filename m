Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTIBCpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTIBCpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:45:42 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:1413 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S263388AbTIBCpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:45:41 -0400
Message-ID: <001001c370fa$c47f2e30$6401a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test4, psmouse doesn't autoload, CONFIG_SERIO doesn't module
Date: Mon, 1 Sep 2003 22:34:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some questions

1. Why doesn't the PS/2 mouse autoload as a module?
Running 2.6.0-test4, psmouse doesn't autoload as a module.  Oddly, neither
gpm nor X complains about the missing module, the mouse just doesn't work.
But if I modprobe psmouse, the cursor starts moving.  I verified that
/dev/psaux uses char-major-10-1 and that it has an "alias char-major-10-1
psaux" in modprobe.conf.

2. Why do I have to compile CONFIG_SERIO into the kernel?  If it's set to
module, then the link step for various modules complains about missing atkbd
symbols?

I'd appreciate any hints on what to try.

thanks, jeff

Some more questions to help me understand how this works...

1. What does kmod send to modprobe?  From looking at modprobe.conf
apparently "char-major-x-y".
2. Does kmod send any other strings to modprobe?
3. Documentation/kmod.txt says "passing the name (to modprobe) that was
requested", couldn't this be more explicit?
4. Does kmod gets the major-minor number from the device file upon open(),
or some other way?

