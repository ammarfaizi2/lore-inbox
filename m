Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTGCTWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTGCTWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:22:35 -0400
Received: from imap.gmx.net ([213.165.64.20]:23957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265374AbTGCTWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:22:30 -0400
Message-ID: <3F04823A.5030403@gmx.at>
Date: Thu, 03 Jul 2003 21:21:30 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Wil Reichert <wilreichert@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: highpoint driver problem, 2.4.21-ac4
References: <4V9E.47E.39@gated-at.bofh.it> <4V9E.47E.37@gated-at.bofh.it> <4WyE.5oC.19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wil Reichert wrote:
 >>> The on-board Highpoint controller (HPT372A) on my DFI NF2 is
 >>> having issue.  Loading the hptraid module results in a 'No such
 >>> device' message while the hpt366 module segfaults and leaves an
 >>> oops in my logs.  These errors occur regardless of the disk/raid
 >>> configuration in the hpt BIOS.   Following are the oops trace, an
 >>> lsmod, the .config and a lspci -vvv.
 >>
 >> The crash occurs in the hpt366 module. Loading hptraid will not
 >> work because it depends on the kernel to claim the disks of the
 >> raid volume (that is what hpt366 would do). I will add autoloading
 >> of the ide-controller module in the next raid-driver release.
 >> However, I do not know why the kernel oopses. You might want to try
 >> to build the hpt366 code into the kernel instead of a module. If it
 >> works it would probably mean that "ide_hwif_t *hwif" was not
 >> properly initalized.
 >
 > I initially had all the hpt modules built into the kernel, but that
 > would also produce an oops and die immediately after ID'ing the two
 > drives I have on attached.  Would any more information be of use to
 > you?

2.4.21-ac4 contains several fixes for the hpt37x. Please try this patch out.

bye,
Wilfried


