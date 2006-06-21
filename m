Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWFUVtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWFUVtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWFUVtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:49:46 -0400
Received: from storage.ukr.net ([212.42.65.69]:52677 "EHLO storage.ukr.net")
	by vger.kernel.org with ESMTP id S1030188AbWFUVtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:49:45 -0400
From: "=?windows-1251?Q?=C0?=.=?windows-1251?Q?=C8?=.
	=?windows-1251?Q?=D7=E5=ED=F6=EE=E2?=" <chentsov@ukr.net>
To: linux-kernel@vger.kernel.org
Reply-To: "=?windows-1251?Q?=C0?=.=?windows-1251?Q?=C8?=.
	  =?windows-1251?Q?=D7=E5=ED=F6=EE=E2?=" <chentsov@ukr.net>
Subject: PROBLEM: compilation error when including asm/system.h in user mode code
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19 advanced
X-Originating-IP: [212.42.75.4]
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
Message-Id: <E1FtAZz-0001sx-Vj@storage.ukr.net>
Date: Thu, 22 Jun 2006 00:49:43 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
Starting 2.6.15 'include/asm-i386/system.h' has lines (301-304)

extern unsigned long cmpxchg_386_u8(volatile void *, u8, u8);
extern unsigned long cmpxchg_386_u16(volatile void *, u16, u16);
extern unsigned long cmpxchg_386_u32(volatile void *, u32, u32);

Here u8, u16, u32 types used in nonkernel namespace producing undefined type
errors.

Solution:
Rename types to __u8, __u16, __u32.

Since a few distributions derive their glibc kernel headers directly from
kernel the problem is quite relevant.

Regards,
A. Chentsov.


