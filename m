Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUESKmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUESKmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUESKmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:42:07 -0400
Received: from stingr.net ([212.193.32.15]:718 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S263484AbUESKmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:42:04 -0400
Date: Wed, 19 May 2004 14:41:52 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: problems with ext3 fs, kernels up to 2.6.6-rc2
Message-ID: <20040519104152.GM19183@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

For a long time I'm sorta have the following problem.

I have ext3 partition with dir_index turned on. I have programs, which
store many files on it (for example, Maildir mailboxes for 500+ users,
about 200k files).

Sometimes something going wrong. I am noticing it by rdiff-backup on
this partition producing the following output:
ListError goloub/Maildir/cur/1082623479.1763_0.ns:2,S [Errno 5]
Input/output error:
+'/mnt/mail/goloub/Maildir/cur/1082623479.1763_0.ns:2,S'

Yes, when I am doing strace ls -al (failed file), I am seeing -EIO

lstat64("/mnt/mail/goloub/Maildir/cur/1082623479.1763_0.ns:2,S",
0x806408c) = -1 EIO (Input/output error)

I know, so when I will e2fsck it it will be repaired. But how I can
help debug it?

Which on-disk structs I need to examine, maybe extract, and send to
someone?

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
