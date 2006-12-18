Return-Path: <linux-kernel-owner+w=401wt.eu-S1753569AbWLRJHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbWLRJHu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbWLRJHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:07:50 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:44654 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbWLRJHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:07:49 -0500
Date: Mon, 18 Dec 2006 10:06:12 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Stefan Seyfried <seife@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: s2disk curiosity  :)
Message-ID: <20061218100612.02d807f7@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using uswsusp and with commit

	3592695c363c3f3119621bdcf5ed852d6b9d1a5c
	uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode")


My PC power-light starts flashing during s2disk as expected (comment
from the commit that fixes the same thing in in-kernel suspend):

"    [PATCH] swsusp: fix platform mode

    At some point after 2.6.13, in-kernel software suspend got "incomplete" for
    the so-called "platform" mode.  pm_ops->prepare() is never called.  A
    visible sign of this is the "moon" light on thinkpads not flashing during
    suspend.  Fix by readding the pm_ops->prepare call during suspend."


BUT: another thing that happens is that now my PC powers itself on
_without_ pressing the power button (just by plugging the AC power).


I don't like this all that much...

I understand this is probably MOBO specific but, is this behaviour
expected/common?

-- 
	Paolo Ornati
	Linux 2.6.20-rc1-g99f5e971 on x86_64
