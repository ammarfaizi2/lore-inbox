Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUKGTIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUKGTIp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 14:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUKGTIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 14:08:45 -0500
Received: from mail3.centrum.cz ([213.29.7.231]:57509 "EHLO mail3.centrum.cz")
	by vger.kernel.org with ESMTP id S261676AbUKGTIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 14:08:40 -0500
Date: Sun, 07 Nov 2004 20:07:45 +0100
From: <ledva@centrum.cz>
To: <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Subject: bugy config cpu 386 selection CONFIG_X86_TSC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20041107190748Z311672-340+66713@mail.centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just had to compile kernel for zipslack for 386 because
it's default has some problem with *WP
I chose linux-2.4.27 tree.
Sure i did it on other machine:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
flags           : fpu vme de pse tsc msr mce cx8 mmx

I did

make mrproper && make menuconfig && \
make dep && make bzImage

selected 386 and several other options as you
can see in .config which can be obtained from
http://portal.promon.cz/ledvinka/i/tscerr/config

All changes were done entirely via menuconfig.
Result of booting up the kernel is:

CPU: 386
Kernel panic: Kernel compiled for Pentium+, requires TSC feature!
In idle task  - not syncing

So i guess i just have to comment out
CONFIG_X86_TSC
that will be my first try.

Do not  i have switch it for:
CONFIG_X86_TSC_DISABLE
Sounds like it is option for kernel
not to use TSC although it's present?

Please CC me. Words comment out OR switch should be enough ;-)
