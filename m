Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTA1OsQ>; Tue, 28 Jan 2003 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267343AbTA1OsP>; Tue, 28 Jan 2003 09:48:15 -0500
Received: from thoth.sbs.de ([192.35.17.2]:25744 "EHLO thoth.sbs.de")
	by vger.kernel.org with ESMTP id <S267339AbTA1OsO>;
	Tue, 28 Jan 2003 09:48:14 -0500
Message-ID: <6134254DE87BD411908B00A0C99B044F04F7B31A@mowd019a.mow.siemens.ru>
From: Borzenkov Andrey <Andrey.Borzenkov@siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: What happens with busy inode->i_sb after sb is gone?
Date: Tue, 28 Jan 2003 17:58:29 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for stupid question.

It is possible that we have busy inode that survives kill_super. One
possible scenario would be umount with MNT_DETACH.

In this case sb is gone and we have inode with i_sb pointing nowhere? What
happens then on any operation that tries to access sb, final iput in the
first case.

TIA

-andrey
