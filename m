Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTJ0UvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbTJ0UvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:51:05 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:47745
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263587AbTJ0UvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:51:03 -0500
From: John Mock <kd6pag@qsl.net>
To: David Ford <david+powerix@blue-labs.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: test9 suspend problems
Message-Id: <E1AEEKl-0000yc-00@penngrove.fdns.net>
Date: Mon, 27 Oct 2003 12:51:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Software suspend failing with 'uhci-hcd' is a known problem under 2.6.0
(see Bug #1373):

    http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/1805.html
    http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/1867.html
    http://bugzilla.kernel.org/show_bug.cgi?id=1373

It was reported a while ago (in 2.5.73-mm1):

    http://www.ussg.iu.edu/hypermail/linux/kernel/0306.3/1093.html

According to current release critera, it seems that most software-suspend
related issues will have to wait until after 2.6.0 is released in terms
of the regular kernel. (Maybe a private patch might be available sooner.)

If your only USB devices are mice and/or keyboards, then you can probably
put a 'rmmod uhci-hcd'/'modprobe uhci-hcd' pair in your hiberation script.

That fix is unlikely to work for things like file-oriented devices (such 
as digital cameras).
				-- JM
