Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUHYQQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUHYQQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHYQQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:16:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:46526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268043AbUHYQQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:16:14 -0400
Date: Wed, 25 Aug 2004 09:14:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Arne Henrichsen <ahenric@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_sem* undefined
Message-Id: <20040825091413.0c43c78d.rddunlap@osdl.org>
In-Reply-To: <20040825115020.58522.qmail@web41501.mail.yahoo.com>
References: <20040825115020.58522.qmail@web41501.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 12:50:20 +0100 (BST) Arne Henrichsen wrote:

| Hi,
| 
| I am running kernel 2.6.8 and have noticed that in
| linux/sem.h the function declarations for sys_semop,
| sys_semop etc have been removed (as far as I can see
| from 2.6.4 onwards). Now when I compile my code I get
| the sys_sem* undefined warning messages. Which header
| file do I need to include now to get this support? 

grep(1) finds sys_semop here:

./linux/syscalls.h:446:asmlinkage long sys_semop(int semid, struct sembuf __user
 *sops,

Yes, include/linux/syscalls.h contains syscall prototypes.


| Also when I want to load my module with insmod it
| cannot find these symbols.

syscalls aren't called by name, so that's no surprise.


--
~Randy
