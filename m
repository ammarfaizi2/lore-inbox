Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTJHLdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 07:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTJHLdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 07:33:03 -0400
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:5504 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id S261368AbTJHLdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 07:33:01 -0400
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 mightsleep during e3fsck
Date: Wed, 8 Oct 2003 13:41:08 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310081341.08392.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

during the "check ext3 after 26 unchecked mounts" today I got the 
following: (excerpt from dmesg)



EXT3 FS on hda3, internal journal
...
Debug: sleeping function called from invalid context at 
include/asm/uaccess.h:473
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011feda>] __might_sleep+0x9a/0xc0
 [<c010e09a>] save_v86_state+0x6a/0x200
 [<c010ebb7>] handle_vm86_fault+0xc7/0x880
 [<c019113f>] ext3_file_write+0x3f/0xc0
 [<c010c8b0>] do_general_protection+0x0/0x90
 [<c010bba5>] error_code+0x2d/0x38
 [<c010b17b>] syscall_call+0x7/0xb


Thanks, 
Michael
