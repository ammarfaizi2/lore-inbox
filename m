Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVAKHjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVAKHjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVAKHjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:39:14 -0500
Received: from news.cistron.nl ([62.216.30.38]:33668 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262460AbVAKHjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:39:11 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: RAM drive
Date: Tue, 11 Jan 2005 07:39:10 +0000 (UTC)
Organization: Cistron Group
Message-ID: <crvvqu$icc$1@news.cistron.nl>
References: <20050111014406.18739.qmail@web51805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1105429150 18828 62.216.29.200 (11 Jan 2005 07:39:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050111014406.18739.qmail@web51805.mail.yahoo.com>,
Phy Prabab  <phyprabab@yahoo.com> wrote:
>I need some assistance with creating a RAM disk of 8G
>and mounting it.  I am using 2.6.10 with this
>proceedure:
>
>(ramdisk support enabled)
>dd bs=512 if=/dev/zero of=/dev/ram0 count=16384000
>mkfs.ext2 -m0 /dev/ram0 8192000
>mount -t ext2 /dev/ram0 /ramdisk0
>mount: wrong fs type, bad option, bad superblock on
>/dev/ram0,
>       or too many mounted file systems
>
>I am not sure what the issue is.  It worked on the
>2.4.x series.

I seem to remember that you must explicitly set the blocksize
to 1024 or 4096 when creating the filesystem. Eg mkfs.ext2 -b1024
or mkfs.ext2 -b4096 (don't remember which one exactly).

But with 2.6, why not use tmpfs ? Mount -t tmpfs -o size=8192000000 /ramdisk0

Mike.

