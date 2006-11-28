Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935675AbWK1P6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935675AbWK1P6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 10:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935681AbWK1P6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 10:58:50 -0500
Received: from il.qumranet.com ([62.219.232.206]:58081 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S935675AbWK1P6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 10:58:49 -0500
Message-ID: <456C5CB8.6090909@qumranet.com>
Date: Tue, 28 Nov 2006 17:58:48 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] KVM userspace release 5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://kvm.sourceforge.net

Changes:

 - AMD SVM support (x86-64 hosts only)
 - Preliminary live migration support
 - 'make install' also installs kernel modules, if selected
 - random fixes

The kernel package in this release produces three modules: kvm.ko, 
kvm-intel.ko, and kvm-amd.ko.  To use kvm, you must either 'modprobe 
kvm-$arch', or 'insmod /path/to/kvm.ko; insmod /path/to/kvm-$arch.ko'.

The new live migration feature (at present more accurately described as 
"zombie migration", since the guest does not make progress while it is 
migrated) can be used as follows (assume two hosts A, B):

1. A: Start a VM. Play with it for a while.
2. B: Start a VM with *exactly* the same options, plus a '-S'.  The disk 
images must be shared.
3. A: switch to monitor (alt-ctrl-2), type 'stop'.
4. B: switch to monitor, type 'migration listen'.
5. A: 'migration connect'
6. A: 'migration start offline'
7. A: 'quit'
8: B: 'cont', and switch to display (alt-ctrl-1)


-- 
error compiling committee.c: too many arguments to function

