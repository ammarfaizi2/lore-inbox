Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTAaOJW>; Fri, 31 Jan 2003 09:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTAaOJW>; Fri, 31 Jan 2003 09:09:22 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:25986 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S266907AbTAaOJV> convert rfc822-to-8bit;
	Fri, 31 Jan 2003 09:09:21 -0500
Date: Fri, 31 Jan 2003 15:18:42 +0100 (CET)
From: =?ISO-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Default mount options ignored on ext3
Message-ID: <Pine.LNX.4.33.0301311510460.22604-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems that "Default mount options" from ext3 fs is ignored by
the linux kernel. I have just set "Default mount options" to
"journal_data" on my root fs but kernel still mounts it with
journal_data_ordered:

(part of dmesg)
EXT3-fs: mounted filesystem with ordered data mode.
                                 ~~~~~~~~~~~~~~~~~
VFS: Mounted root (ext3 filesystem) readonly.

$ tune2fs -l /dev/md0
tune2fs 1.32 (09-Nov-2002)
Filesystem volume name:   /
Last mounted on:          <not available>
Filesystem UUID:          cfaec15d-a1dc-46fe-af5b-c9f0a087c078
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal dir_index filetype needs_recovery sparse_super
Default mount options:    journal_data
                          ~~~~~~~~~~~~
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
(...)

$ uname -r
2.4.21-pre4

And ofcourse, it is not possible to remount ext3 fs and change
journalling mode.

Best regards,

			Krzysztof Olêdzki

