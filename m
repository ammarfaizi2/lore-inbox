Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVBWWzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVBWWzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVBWWx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:53:57 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:9660 "EHLO
	pc18.dolda2000.com") by vger.kernel.org with ESMTP id S261664AbVBWWxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:53:13 -0500
Subject: ipt_owner panic on 2.6.10-1.12_FC2
From: Fredrik Tolf <fredrik@dolda2000.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 23 Feb 2005 23:53:09 +0100
Message-Id: <1109199189.15302.21.camel@pc7.dolda2000.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On the Linux router I'm running, I use the ipt_owner iptables module,
and since a few kernel versions back, I've begun getting kernel panics
in the ipt_owner module.

Unfortunately, the start of it coincided with a CPU upgrade of the
router, so at first I thought it was a hardware failure. Therefore, I
didn't note on what kernel version it first started happening. This
kernel version is a stock Fedora Core 2 kernel from FC's yum repo,
2.6.10-1.12_FC2.

Anyhow, I'm getting this panic message:
Kernel panic - not syncing: net/ipv4/netfilter/ipt_owner.c:38:
spin_lock(kernel/fork.c:ca2dc044) already locked by fs/file_table.c/153

I've got a long stack trace in the same photograph that I took of the
monitor. Please tell me if you want it. I've seen the file and source
line of the "already locked by" vary (such as "already locked by
fs/open.c/someline"... it was somewhere in sys_close() at that time), so
it doesn't seem to be depending on that.

Not sure if this is the kind of error that goes to the LKML. Please tell
me if I got it wrong.

Also, if anyone has the time, please clear up this confusion for me -- I
assume from the message that this panic is because one thread tries to
lock the same lock twice, but I've always thought that Linux spinlocks
are recursively lockable. Am I just wrong about them being recursively
lockable, or does this panic have another cause?

Thanks for your time!

Fredrik Tolf


