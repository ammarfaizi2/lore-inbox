Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFZNrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFZNrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 09:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFZNrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 09:47:03 -0400
Received: from mail.linicks.net ([217.204.244.146]:56079 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261194AbVFZNrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 09:47:00 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 breaks 8139cp
Date: Sun, 26 Jun 2005 14:46:57 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506261446.57802.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems that whatever is causing the bug i'm seeing was a change that 
> involved the network driver/interrupt subsystem and not actually the 
> 8139too driver, this was done at around 2.6.3-2.6.4.   A NAPI patch that 
> was introduced at that time basically reverted the interrupt function 
> and removed the poll functions from the driver (via not enabling napi in 
> Kconfig).

Ummm.  I was involved in this.  Here is the 'final' post after Mr Hirofumi 
found the cause of my issues:

http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/1709.html

But I looked at what he said and found the real problem on my system (after 
all that):

http://www.ussg.iu.edu/hypermail/linux/kernel/0403.1/1537.html

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
