Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278286AbRJMM7U>; Sat, 13 Oct 2001 08:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278285AbRJMM7L>; Sat, 13 Oct 2001 08:59:11 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:19219 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278286AbRJMM6z>;
	Sat, 13 Oct 2001 08:58:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Corrupt ext2/ext3 directory entries not recovered by e2fsck
In-Reply-To: Your message of "Sat, 13 Oct 2001 22:44:34 +1000."
             <17469.1002977074@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 22:59:09 +1000
Message-ID: <17538.1002977949@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 22:44:34 +1000,
Keith Owens <kaos@ocs.com.au> wrote:
>The filesystem was created as ext3 but is currently being accessed as
>ext2 while I work on XFS and kdb for IA64.  After multiple power rests,
>several directory entries are corrupt.  Attempts to access the files
>get I/O error with nothing in the log.  Running e2fsck does not correct
>the broken directory entry, neither does booting a kernel that supports
>ext3.

I forgot to mention that both fsck.ext2 and fsck.ext3 report

1: Entry 'sendmail.pid' in /var/run (686849) has deleted/unused inode 688415.  CLEARED.
/1: Entry 'crond.pid' in /var/run (686849) has deleted/unused inode 688416.  CLEARED.
/1: Entry 'xfs.pid' in /var/run (686849) has deleted/unused inode 688417.  CLEARED.
/1: Entry 'atd.pid' in /var/run (686849) has deleted/unused inode 688418.  CLEARED.

but the entries are still corrupt.

