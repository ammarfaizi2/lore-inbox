Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTABOTS>; Thu, 2 Jan 2003 09:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTABOTS>; Thu, 2 Jan 2003 09:19:18 -0500
Received: from fmr05.intel.com ([134.134.136.6]:32760 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261907AbTABOTR>; Thu, 2 Jan 2003 09:19:17 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2602AFADC0@pdsmsx32.pd.intel.com>
From: "Wang, Stanley" <stanley.wang@intel.com>
To: "'rusty@rustcorp.com.au'" <rusty@rustcorp.com.au>
Cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel module version support.
Date: Thu, 2 Jan 2003 22:25:31 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rusty
I am interested in your module version support implementation. I've read
your 
description about it.
(http://www.kernel.org/pub/linux/kernel/people/rusty/modversions_support.htm
l)
And I have some questions about the implementation details. Would you like
to help me to 
clarify them?

1. How do you plan to store the version information of a kernel module that
will export some symbols?
(In the version table of "bzImage"? In a specified section in this kernel
module? In other place? Or don't
store?)

2. You mentioned that "modules which want to export symbols place their full
path name 
in the .needmodversion section. Just before the kernel is linked, these
names are extracted, 
and genksyms scans those files to create a version table. This table is then
linked into the kernel". 
And I think we must recalculate all version informaiton every time when we
re built the kernel in this way. 
Why don't we place all the module version information in some files just
like old days.

3. You mentioned that "these symbol versions are then checked on insmod". I
wanna whether it means
you would like to restore the "/proc/ksyms" file or QUERY_MODULE SYSCALL to
export the kernel version
table to the user space application. 

Thanks a lot.

Your Sincerely,
Stanley Wang 

SW Engineer, Intel Corporation.
Intel China Software Lab. 
Tel: 021-52574545 ext. 1171 
iNet: 8-752-1171 
 
Opinions expressed are those of the author and do not represent Intel
Corporation
