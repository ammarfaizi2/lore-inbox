Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSLJSoV>; Tue, 10 Dec 2002 13:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSLJSoV>; Tue, 10 Dec 2002 13:44:21 -0500
Received: from fmr05.intel.com ([134.134.136.6]:58577 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265661AbSLJSoU>; Tue, 10 Dec 2002 13:44:20 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA260216C261@pdsmsx32.pd.intel.com>
From: "Hu, Boris" <boris.hu@intel.com>
To: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>,
       "NPTL list (E-mail)" <phil-list@redhat.com>
Subject: problem about CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID ?
Date: Wed, 11 Dec 2002 02:49:56 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I read create_thread() in NPTL source code, it passes
CLONE_PARENT_SETTID 
| CLONE_CHILD_CLEARTID to sys_clone(). However, in arch/arm/kernel/sys_arm.c

(sys_clone) [kernel 2.5.49]
256         if (clone_flags & (CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID))
257                 return -EINVAL;

 I have searched CLONE_PARENT_SETTID in kernel, it seems only to appear in 
some non-architecture files, such as /include/linux/sched.h and several arch
files,
 but they do little about wrapping.  Why ARM can't support 
(CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID)? 

any comments? thanks a lot. 

  Boris
=========================
To know what I don't know
To learn what I don't know
To contribute what I know
=========================



