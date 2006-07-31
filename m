Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWGaKLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWGaKLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWGaKLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:11:53 -0400
Received: from math.ut.ee ([193.40.36.2]:64756 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751292AbWGaKLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:11:52 -0400
Date: Mon, 31 Jul 2006 13:11:50 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: compat_sys_pselect7 warning
Message-ID: <Pine.SOC.4.61.0607311300460.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.18-rc3 on sparc64 but posting on LKML since the warning 
cones from generic code (although guarded by
#ifdef TIF_RESTORE_SIGMASK).

   CC      fs/compat.o
fs/compat.c: In function 'compat_sys_pselect7':
fs/compat.c:1869: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result

I would just return EFAULT there when copy_to_user returns nonzero value 
but there is some signal mask thing going on that someone more familiar 
with the code should look.

-- 
Meelis Roos (mroos@linux.ee)
