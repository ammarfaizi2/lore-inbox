Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTLSMzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTLSMyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:54:37 -0500
Received: from mail.convergence.de ([212.84.236.4]:27322 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262762AbTLSM2k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:40 -0500
Subject: [PATCH 0/12] LinuxTV.org DVB+V4L fixes
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:38 +0100
Message-Id: <10718369183635@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, hello Linus,

because of the "stable freeze" 2.6.0 release a bunch of patches
for the DVB subsystem has piled up. 8-)

These 12 patches try to sync the DVB drivers hosted by
http://www.linuxtv.org with 2.6.0.

As usual, detailed descriptions are at the beginning of each patch.

Please note that patch "01-DVB-av7110-firmware-removal.diff" now
finally removes the firmware blob for the dvb-ttpci driver, so the
patch is quite large and has only been sent to you in a separate mail.

We're planning to remove the firmware files from other drivers as well.

The firmware removal depends on the latest patch by Manuel Estrada Sainz
<ranty@debian.org> which is currently only in the -mm
tree.

It fixes firmware_class to use a kernel_thread instead of scheduling
a work queue which will freeze the system if you don't use the firmware
hotplug systems. I hope it's ok if you apply this cross-subsystem patch
this time, I'll write a separate mail to Manuel, too.

Please apply.

Thanks!
Michael.

