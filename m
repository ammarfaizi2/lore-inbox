Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUGGMY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUGGMY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUGGMY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:24:29 -0400
Received: from news.cistron.nl ([62.216.30.38]:26082 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264002AbUGGMY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:24:27 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: partitionable md devices and partition detection
Date: Wed, 7 Jul 2004 12:24:26 +0000 (UTC)
Organization: Cistron Group
Message-ID: <ccgq1q$sht$1@news.cistron.nl>
References: <20040707045939.GA20516@ols-dell.iic.hokudai.ac.jp> <16619.35060.821865.570842@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1089203066 29245 62.216.29.200 (7 Jul 2004 12:24:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <16619.35060.821865.570842@cse.unsw.edu.au>,
Neil Brown  <neilb@cse.unsw.edu.au> wrote:
>On Wednesday July 7, chutz@gg3.net wrote:
>> What is the proper way to detect the partitions on a md device during kernel
>> initialization?
>> The real problem I am facing is that I cannot boot my root partition, which is
>> on /dev/md_d0p1, without using an initrd. The kernel complains that the device
>> md_d0p1 does not exist.
>
>Hmm... I guess there isn't.
>I remember having a lot of trouble getting partitions to be recognised
>when an array is first assembled, and deciding it was just easier to
>leave it to user-space.  However that isn't an option when booting
>without an initrd.

That's weird. It has been working for me out of the box.

>The following patch should make it work for the
>  md=d0,....
>case.

So the fact that it works for me is a freak accident?

I have this in lilo.conf:

append="md=d0,/dev/sda,/dev/sdb root=/dev/md_d0p1 "

and this is dmesg:

md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Loading md_d0: /dev/sda
md: bind<sda>
md: bind<sdb>
raid1: raid set md_d0 active with 2 out of 2 mirrors
 md_d0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

Mike.

