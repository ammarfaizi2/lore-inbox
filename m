Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSK0Acs>; Tue, 26 Nov 2002 19:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSK0Acs>; Tue, 26 Nov 2002 19:32:48 -0500
Received: from pcp103897pcs.glstrt01.nj.comcast.net ([68.45.109.175]:6404 "EHLO
	sorrow.ashke.com") by vger.kernel.org with ESMTP id <S262418AbSK0Acr>;
	Tue, 26 Nov 2002 19:32:47 -0500
Date: Tue, 26 Nov 2002 19:40:04 -0500 (EST)
From: Adam K Kirchhoff <adamk@voicenet.com>
X-X-Sender: adamk@sorrow.ashke.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.49 module problem
Message-ID: <20021126193026.Q14666-100000@sorrow.ashke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all.

Sorry to bother everyone with what is probably a stupid user error, but in
case it's not I thought I should post my problem to the list.

I recently upgraded my motherboard to one with an ICH4 IDE controller.
Since it's not supported in 2.4.*, yet, I decided now would be a good time
to try the 2.5.* series.

I grabbed 2.5.49, configured a new kernel, built the kernel and modules.
Once done, I installed the modules (make modules_install), copied the
bzImage and System.map to /boot and rebooted into single user mode.

Everything seems fine except for one issue:  I can't load any modules.
depmod gives:

QM_MODULES: Function not implemented

insmod does the same.

Now, all my googling has turned up are a couple of other users who have
had the problem.  But, in those cases, it's a result of the kernel not
being compiled to support modules.  This is definatley not the case this
time.  Here are the pertinant lines of my .config file:

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_KMOD=y

And, of course, my /lib/modules/2.5.49/kernel directory is full of all the
modules I compiled.

Any idea what the problem might be?  Is this a problem with the kernel or
a problem with the user?  If it's something stupid I'm doing, please
enlighten me.

BTW, this happens with both modutils from Mandrake 9.0 (2.4.19) and the
most recent version (2.4.22).

Thanks :-)

Adam


