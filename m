Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272357AbRH3Rc5>; Thu, 30 Aug 2001 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272358AbRH3Rcr>; Thu, 30 Aug 2001 13:32:47 -0400
Received: from [209.218.224.101] ([209.218.224.101]:19848 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S272360AbRH3Rcj>; Thu, 30 Aug 2001 13:32:39 -0400
Message-ID: <000901c13179$be7b9ae0$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same mountpoint
Date: Thu, 30 Aug 2001 10:32:29 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accidentally <G> I mounted a filesystem from my server onto my workstation
twice. Mount gave me no error....

Both machines are kernel 2.4.9-ac3, both have NFSv3 support, server is using
knfsd, mount is version 2.11b. I export /storage on the server, and mount it
on /storage on my workstation.

When I boot the workstation, it automatically mounts /storage, so
everything's fine. If I then issue a  "mount /storage" command, I don't get
any error. df then reports two identical mounts for /storage. I can continue
to multiple mount (tried up to five mounts). Each "umount /storage" takes
away the most recent mount, with the last one performing a real unmount.

I can't, however, multiple mount any local filesystems (hard disk or CD-ROM
based), and don't have anything else handy to try.

