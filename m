Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264221AbRFMVKt>; Wed, 13 Jun 2001 17:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264230AbRFMVKj>; Wed, 13 Jun 2001 17:10:39 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:15759 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S264221AbRFMVK0>; Wed, 13 Jun 2001 17:10:26 -0400
Message-ID: <3B27D6FE.8CE2A92A@idcomm.com>
Date: Wed, 13 Jun 2001 15:11:26 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: bzDisk compression Q; boot debug Q
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First I have a question about the compression of bzDisk. While trying to
debug the reason for a modular boot failure versus a successful
non-module boot (XFS filesystem for root), I found that I can mount my
initial ramdisk on loopback as a means of examining which modules are
available to it. However, it doesn't actually point out which modules
were loaded at the time when a filesystem mount fails. Viewing ramdisk
is via:
gzip -dc your.img > somefile
mount -o loop somefile somedir

Question 1, how hard would it be to cause failure of mount of root
filesystem to also output a list of current modules it has loaded?

Question 2, apparently ramdisk uses gzip compression; the name of the
kernel from make bzImage seems to maybe refer to bzip2 compression. Is
the kernel image using gzip or bzip2 compression for bzImage? Would
anything be gained in reducing boot size requirements by running bzip2
compression for any initial ramdisk, versus gzip compression?

D. Stimits, stimits@idcomm.com
