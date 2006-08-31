Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWHaSCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWHaSCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWHaSCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:02:37 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:35273 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932431AbWHaSCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:02:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Du8jt0cbRtfA7XEBeaMjV3u8A2HHbMAZUFnguV3ASJDtzgcgPtrYdWYFEkUETRiJxuOq3CfppPGJInYmvxsJsPZsrSimMOFYGcuCAW8UX6W/8n3wbryNd1XU0pzLviH+KwQATB9tdmaM7x00h8mcWmtQnsyNm3JOWZhhJOqn0aU=
Message-ID: <26279fb90608311102w2d74ed03w1ca5d1ea359a8b1b@mail.gmail.com>
Date: Thu, 31 Aug 2006 11:02:35 -0700
From: "Richard Amick" <richa03@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: EXT3-fs error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.8.

In messages:
Aug 31 08:22:34 mail04 kernel: EXT3-fs error (device cciss/c0d1p1):
ext3_add_entry: bad entry in directory #14058742: rec_len is smaller
than minimal - offset=0, inode=0, rec_len=0, name_len=0
Aug 31 08:22:34 mail04 kernel: Aborting journal on device cciss/c0d1p1.
Aug 31 08:22:34 mail04 kernel: ext3_abort called.
Aug 31 08:22:34 mail04 kernel: EXT3-fs error (device cciss/c0d1p1):
ext3_journal_start_sb: <2>ext3_abort called.
Aug 31 08:22:34 mail04 kernel: EXT3-fs error (device cciss/c0d1p1):
ext3_journal_start_sb: Detected aborted journal
Aug 31 08:22:34 mail04 kernel: Remounting filesystem read-only
Aug 31 08:22:34 mail04 kernel: journal commit I/O error
Aug 31 08:22:34 mail04 last message repeated 4 times
Aug 31 08:22:34 mail04 kernel: Detected aborted journal
Aug 31 08:22:34 mail04 kernel: EXT3-fs error (device cciss/c0d1p1) in
ext3_link: IO failure
Aug 31 08:22:34 mail04 kernel: EXT3-fs error (device cciss/c0d1p1):
ext3_readdir: bad entry in directory #14058742: rec_len is smaller than
minimal - offset=0, inode=0, rec_len=0, name_len=0
Aug 31 08:22:34 mail04 kernel: journal commit I/O error

The file system was remounted which seems to clear the error:
Aug 31 09:16:02 mail04 kernel: EXT3-fs error (device cciss/c0d1p1):
ext3_remount: Abort forced by user
Aug 31 09:17:31 mail04 kernel: __journal_remove_journal_head: freeing
b_committed_data
Aug 31 09:17:31 mail04 last message repeated 6 times
Aug 31 09:18:05 mail04 kernel: kjournald starting.  Commit interval 5
seconds
Aug 31 09:18:05 mail04 kernel: EXT3-fs warning (device cciss/c0d1p1):
ext3_clear_journal_err: Filesystem error recorded from previous mount:
IO failure
Aug 31 09:18:05 mail04 kernel: EXT3-fs warning (device cciss/c0d1p1):
ext3_clear_journal_err: Marking fs in need of filesystem check.
Aug 31 09:18:05 mail04 kernel: EXT3-fs warning: mounting fs with
errors, running e2fsck is recommended
Aug 31 09:18:05 mail04 kernel: EXT3 FS on cciss/c0d1p1, internal
journal
Aug 31 09:18:05 mail04 kernel: EXT3-fs: recovery complete.
Aug 31 09:18:05 mail04 kernel: EXT3-fs: mounted filesystem with ordered
data mode.

My question:
How do I determine what is/was contained in "directory #14058742"?

Running e2fsck is really not an option right now as this is a
production server and a very large volume (300GB with 150GB used).

TIA, Rich
