Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVDARS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVDARS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVDARS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:18:57 -0500
Received: from web25603.mail.ukl.yahoo.com ([217.12.10.162]:20558 "HELO
	web25603.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262797AbVDARS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:18:56 -0500
Message-ID: <20050401171852.36514.qmail@web25603.mail.ukl.yahoo.com>
Date: Fri, 1 Apr 2005 19:18:52 +0200 (CEST)
From: Uwe Zybell <u_zybell@yahoo.de>
Subject: fs/partitions/msdos.c, scripts/packages/Makefile
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First things first: Pls CC me, I'm not subscribed.

There is a line in fs/partitions/msdos.c that lets extended partitions 
be max 1k (..."==1 ? 1 : 2"...). The comment explains it to protect 
sysadmins from themselves. But /dev/hda isn't similarly protected. That
is because it would prohibit other uses. But now I have found a 
legitimate use for extended partitions in their full length. Emulation.
Please remove this, or make it a config option.

Next problem: make O=... ...-pkg doesn't work. Reason: In
scripts/packages/Makefile
all -pkg target call $(MAKE) but from $(obj). This line(s) must be
augmented
with "-f $(srcdir)/Makefile". I don't know if $(srcdir) must be
conditional on O.


	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
