Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWGFXqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWGFXqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWGFXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:46:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26795 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751073AbWGFXqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:46:45 -0400
Subject: Re: Linux v2.6.18-rc1: printk delays
From: john stultz <johnstul@us.ibm.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44AD9605.6000601@imap.cc>
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9605.6000601@imap.cc>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 16:46:39 -0700
Message-Id: <1152229599.24656.175.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 01:00 +0200, Tilman Schmidt wrote:
> With kernel 2.6.18-rc1 I am experiencing strange delays before printk
> messages from my driver appear in the syslog. The last couple of printk
> lines only appear if I hit a key on the system keyboard. Even just
> pressing and releasing a shift key will do. Other input, like connecting
> with ssh from another computer and typing into that session or moving or
> clicking the mouse, doesn't help. At the same time, userspace syslog
> messages like those from sshd appear just fine.
> 
> Example excerpt from /var/log/messages:
> 
> > Jul  7 00:16:08 gx110 kernel: [  746.583136] gigaset: 0: if_write()
> > Jul  7 00:16:08 gx110 kernel: [  746.583154] gigaset: CMD Transmit (10 bytes):
> > Jul  7 00:16:08 gx110 kernel: [  746.583203] bas_gigaset: setting ATREADY time
> > Jul  7 00:16:08 gx110 kernel: [  746.585887] bas_gigaset: write_command: sent 
> > Jul  7 00:16:08 gx110 kernel: [  746.612869] gigaset: received response (6 byt
> > Jul  7 00:16:28 gx110 sshd[6134]: Accepted publickey for ts from 192.168.59.12
> > Jul  7 00:28:26 gx110 kernel: [  746.687844] gigaset: 0: if_write()
> > Jul  7 00:28:26 gx110 kernel: [  746.687944] gigaset: CMD Transmit (17 bytes):
> > Jul  7 00:28:26 gx110 kernel: [  746.688002] bas_gigaset: setting ATREADY time
> > Jul  7 00:28:26 gx110 kernel: [  746.690803] bas_gigaset: write_command: sent 
> 
> Note how the PRINTK_TIME timestamps increase in sub-second increments
> while syslogd's timestamps show an enormous gap after 00:16:08.
> 
> With kernel 2.6.17.1 on the same machine there are no such delays. All
> printk messages appear immediately, and the deltas in PRINTK_TIME and
> syslogd timestamps are quite consistent.

Hmmm. I'm assuming this is i386? Could you send me a full dmesg?

Also does booting w/ clocksource=jiffies change the behavior?

thanks
-john


