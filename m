Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVAHSXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVAHSXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVAHSXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:23:24 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:49503 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261241AbVAHSXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:23:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=aqXZJjxoCnqJ8lpQz6ifQHuyyVTIPPC0snh5JLyz2jRVy5KvVc3VkPCPQ8ShgKxmC7r51IoD/xM233IdwKX57tjrU2JfDrIUdHUoOhPA49AyvMKgQj7UKIrfCQ0ibh1nQHYaA9P4VGz1FMljZRrphyljemku4MD7yIEJKifdFEY=
Message-ID: <9e473391050108102355c9a714@mail.gmail.com>
Date: Sat, 8 Jan 2005 13:23:20 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: kernel versions on Linus bk tree
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just came across a problem with the way the kernel is being
versioned. The DRM driver needs an IFDEF for the four level page table
change depending on kernel version built against. I used this:
#if LINUX_VERSION_CODE < 0x02060a

The problem is that 2.6.10 was released on kernel.org without the four
level change. But Linus bk which also has version 2.6.10 has the
change. Is there some way around this problem?

One solution would be to bump the version in Linus bk to 2.6.11-rc1 on
the first check in after 2.6.10 is cut. The general case of this would
be to always bump the Linus bk version number immediately after
cutting the released version.

I've been bitten by this ambiguity before when kernels from Linus BK
have more code in them than the one from kernel.org and have the same
version number. Changing the timing of the version bump would lessen
this problem since kernels complied from Linus bk tend to have a short
life.


-- 
Jon Smirl
jonsmirl@gmail.com
