Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSFKHw0>; Tue, 11 Jun 2002 03:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSFKHwZ>; Tue, 11 Jun 2002 03:52:25 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:17388 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S316899AbSFKHuu>; Tue, 11 Jun 2002 03:50:50 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: dirty buffers and umount/remount
Date: Tue, 11 Jun 2002 00:50:46 -0700
Message-ID: <FEEFKBEFIEBONNKJABKDGEHIDNAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

I have a question that should be simple to answer.

When building a system I need to make sure that whenever user
wants to save configuration to nonvolatile storage (i.e., disk),
all dirty buffers are flushed to disk. Basically I do the following:

1) mount filesystem X from read-only to read-write.
2) save all configuration files to a directory A on X.
3) do a sync.
4) write a label file in A saying "this marks a successful save of
all the configuration files".
5) remount X as read-only.

The problem is that 3) takes quite long time to finish (even most files
in 2) are opened with O_SYNC).

I am wondering if 3) is necessary or not. When the filesystem is remounted
from rw to ro, are all dirty buffers related to it flushed to disk? How
about
umount?

The last related question: is the kdev field in the buffer head the physical
block device (i.e., /dev/hda) or the logical block device (i.e., /dev/hda7)?

Thanks a lot.

Hua

