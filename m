Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTJUVPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbTJUVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:15:00 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:37512
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263394AbTJUVO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:14:58 -0400
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test8] Difference between Software Suspend and Suspend-to-disk?
Message-Id: <E1AC3qP-00061Y-00@penngrove.fdns.net>
Date: Tue, 21 Oct 2003 14:15:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > > They're competing implementations of the same mechanism.
    >
    > And neither one works reliably, I might add. They both appear to save
    > the current state to disk, but no matter what I try, I can't make it
    > resume properly.

    Well, I could suspend/resume correctly first time I tried (runlevel 2 and
    disabling nearly everything to minimize loss of data on crash).

    The second test in X resulted in a 'double fault'...

What happens if you turn off X and/or run X in some kind of framebuffer
mode (probably VESA mode)?  That's the only way it will work for me.

The native mode X drivers like to hack the hardware (look at all the PCI
analysis in XFree86.0.log if you want to see what i'm talking about).
If X sets up the hardware in a special way, then if LINUX gets suspend
and resumed (re-booted, from the standpoint of the display hardware),
then any state that X set up for itself will be hopelessly lost.

So i'm not sure X in DRI mode can work at all, at least, not the version
that i'm running (4.2.1-11).
				  -- JM
