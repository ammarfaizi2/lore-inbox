Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422944AbWJFUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422944AbWJFUoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422943AbWJFUoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:44:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53155 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932629AbWJFUoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:44:01 -0400
Date: Fri, 6 Oct 2006 16:43:58 -0400
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1 boot failure--ops in mpu401_init?
Message-ID: <20061006204358.GB18026@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A machine that booted fine under 2.6.18-rc6 is failing to boot with
2.6.19-rc1.  After commenting out infinite loop of "Spurious ACK"
messages from atkbd.c that were hiding the original OOPS, I see the an
oops at klist_del+0xd/0x50 with a stack like:

bus_remove_device+0x9f/0xc0
device_del+0x17a/0x1b0
platform_device_del+0x69/0x80
platform_device_unregister+0xd/0x20
alsa_card_mpu401_init+0x7a/0x90
init+0x7f/0x260
kernel_thread_helper+0x7/0x10

Unfortunately I can't actually see the top of the OOPS.  (And haven't
had any luck getting a serial console to work yet...)

I also probably won't have time to try a git-bisect in the next few
days, though I could try it eventually if it'd help.

Let me know of any other details that would be helpful.

--b.
