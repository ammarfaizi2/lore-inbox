Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSHFPqQ>; Tue, 6 Aug 2002 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHFPqQ>; Tue, 6 Aug 2002 11:46:16 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:39429 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S311885AbSHFPqP>;
	Tue, 6 Aug 2002 11:46:15 -0400
To: linux-kernel@vger.kernel.org
Subject: Problems with NFS exports
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 06 Aug 2002 17:49:53 +0200
Message-ID: <87eldchtr2.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing weired errors with nfsctl():

This works:

nfsservctl(NFSCTL_EXPORT, "deneb.enyo.de", "/mnt/storage/2/backup/deneb/tmp", makedev(3, 66), ino 167772288, uid 65534, gid 65534) = 0

But a subsequent call fails:

nfsservctl(NFSCTL_EXPORT, "deneb.enyo.de", "/mnt/storage/2/backup/deneb", makedev(3, 66), ino 150995072, uid 65534, gid 65534) = -1 EINVAL (Invalid argument)

I don't understand what makes the difference (the inode values are
correct).  This is kernel 2.4.18 with XFS support, and the directory
resides on an XFS file system.

Any ideas?
