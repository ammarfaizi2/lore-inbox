Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUHNQyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUHNQyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUHNQyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:54:00 -0400
Received: from mail501.nifty.com ([202.248.37.209]:16341 "EHLO
	mail501.nifty.com") by vger.kernel.org with ESMTP id S264153AbUHNQxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:53:53 -0400
To: linux-kernel@vger.kernel.org
Subject: TG3 doesn't work in kernel 2.4.27
From: Tetsuo Handa <a5497108@anet.ne.jp>
Message-Id: <200408150152.EAC63479.8815296B@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Sun, 15 Aug 2004 01:53:49 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using tg3.o with DHCP and PXE boot environment
and I updated from 2.4.26 to 2.4.27,
but tg3.o became not working with IBM BladeCenter.

I think tg3.o in 2.4.27 is generating something broken arp.
When I run 'arp' in the DHCP server (who doesn't use tg3.o),
the entry with <incomplete> status appears.
The IP address which has the <incomplete> status is
the DHCP client's (who is using tg3.o in 2.4.27).

The workaround I took is to replace tg3.h and tg3.c
in 2.4.27 with the files in 2.4.26, and it seems working fine.

Thanks.

--
Tetsuo Handa
