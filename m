Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbTAGIuh>; Tue, 7 Jan 2003 03:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTAGIuh>; Tue, 7 Jan 2003 03:50:37 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1796 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267347AbTAGIug>;
	Tue, 7 Jan 2003 03:50:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301070859.h078xEnI000337@darkstar.example.net>
Subject: Re: Undelete files on ext3 ??
To: maxvaldez@yahoo.com (Max Valdez)
Date: Tue, 7 Jan 2003 08:59:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1041911922.29225.1.camel@garaged.fis.unam.mx> from "Max Valdez" at Jan 06, 2003 09:58:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way to revert the stupid mistyping of "rm file *" on ext3??

There is no simple way, no.

> I hope there is a way, because I dont have a backup of some files i
> mistakenly deleted

The only thing I can suggest is this:

* Do not write anything else to the partition, and immediately
  re-mount it read-only.

E.G.:

mount -oremount -oro /dev/hda3

* Use dd to copy the entire contents of the partition to a file on
  another partition.

E.G.:

dd if=/dev/hda3 of=/partition_image

* Search through that file for the fragments of your lost files.

E.G.:

grep "Some text that you are looking for" /partition_image

If it is a text file that you've lost, it's possible that you might be
able to recover some of it quite easily, using grep to search for the
fragments.  If it's anything else, you'll probably not be able to
recover it, unless you have the details of the file format.

John.
