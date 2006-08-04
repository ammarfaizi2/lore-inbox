Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161388AbWHDT4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161388AbWHDT4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWHDT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:56:21 -0400
Received: from smtp3.Stanford.EDU ([171.67.20.26]:11217 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S1161388AbWHDT4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:56:20 -0400
Message-ID: <1154721378.44d3a6627e951@webmail.stanford.edu>
Date: Fri,  4 Aug 2006 12:56:18 -0700
From: Brannon Barrett Klopfer <bklopfer@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: Completely dead on resume (no caps lock, nada)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Authenticated-User: bklopfer
X-Originating-IP: 209.77.201.203
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry to bug the entire list with such a vaugue post, but I'm not sure what
driver/subsystem is causing this problem. I'm sure you all are sick of "My
computer won't suspend, what do I do?" posts, but...well, my computer won't
suspend...


It's a brand-new HP dv8000t laptop (Phoenix BIOS, latest version, core duo,
ahci/ata_piix [native/legacy]). Suspending (echo mem > /sys/power/state)
works fine, but upon resuming, absolutly nothing works -- backlight stays
off, caps/numlock, network, etc. all dead. I've also tried

# cat `which poweroff` > /dev/null # cache it, in case disk dies upon resume
# echo mem > /sys/power/state ; poweroff -f

but it still just hangs (i.e., seems the entire system is just...dead). I've
tried numerous patches from here and there, and tried both native (ahci) and
legacy (ata_piix) sata, and a kernel with as little support as possible --
no usb, ide, smp, module, preempt, etc. I won't flood the lists with other
info, but it's all at

http://www.stanford.edu/~bklopfer/wontsuspend/

I'd be more than happy to try patches/let someone ssh into my box if it'd
help (new, so nothing sensitive on it yet).

Thanks,
Brannon Klopfer

