Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264659AbUD1FO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbUD1FO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUD1FO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:14:59 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:53675 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264659AbUD1FO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:14:57 -0400
Date: Wed, 28 Apr 2004 00:18:12 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pdflush eating a lot of CPU on heavy NFS I/O
Message-ID: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Running any kernel from the 2.6.6-rc* series (and a few previous
-mm*'s), the pdflush process starts using near 100% CPU indefinitely after
a few minutes of initial NFS traffic, as far as I can tell.

To trigger this, I can either compile a kernel with the source residing on
an NFS share, or compile something bigger, like KDE.

I get the same results running on a PIII with an i815 chipset with
ReiserFS 3, or a newer nForce2 board with an Athlon XP on ext3, so I don't
think it has to do with the IDE chipsets or filesystems. pdflush has
something to do with writing back FS data, and NFS is just the common
factor between systems that experience this problem. pdflush just seems to
hang when the system is heavily loaded and eat up all CPU resources even
when the system is otherwise idle. Renice failes to reschedule pdflush.

 This didn't seem to be a problem with 2.6.5 or 2.4. Is there something I
can do to control pdflush or to provide more information?

Thanks
 - Brent


