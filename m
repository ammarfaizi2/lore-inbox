Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUGGE7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUGGE7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUGGE7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:59:45 -0400
Received: from 142.13.111.219.st.bbexcite.jp ([219.111.13.142]:54699 "EHLO
	tiger.gg3.net") by vger.kernel.org with ESMTP id S264896AbUGGE7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:59:43 -0400
Date: Wed, 7 Jul 2004 13:59:40 +0900
From: Georgi Georgiev <chutz@gg3.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: partitionable md devices and partition detection
Message-ID: <20040707045939.GA20516@ols-dell.iic.hokudai.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the proper way to detect the partitions on a md device during kernel
initialization?

The real problem I am facing is that I cannot boot my root partition, which is
on /dev/md_d0p1, without using an initrd. The kernel complains that the device
md_d0p1 does not exist.

If I use md=d0,/dev/hdc1,/dev/hde1,/dev/hdg1,/dev/hdk1,/dev/hdm1, after the
system boots (and booting from an ordinary non-raid device), I only have
/sys/block/md_d0/, but nothing below it. Nothing about md_d0p1 is reported in
/proc/partitions either.

If I run fdisk on /dev/md_d0 the missing partition entries appear.

The same behavior is observed when autodetecting the raid array using raid=part
instead of the md=d0 line.

Thanks for any insight.

Please, do not remove me from the CC.

-- 
*)   Georgi Georgiev   *) April 1 This is the day upon which we are    *)
(*    chutz@gg3.net    (* reminged of what we are on the other three   (*
*)  +81(90)6266-1163   *) hundred and sixty-four. -- Mark Twain,       *)
(* ------------------- (* "Pudd'nhead Wilson's Calendar"               (*
