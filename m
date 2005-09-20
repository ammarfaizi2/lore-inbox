Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVITX3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVITX3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVITX3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:29:50 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:57322 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbVITX3t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:29:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ku6t35FV1mU7caapUVLDVbTIMtGTPcwgj272nWLFZERQ03ygUIhU6Fv9JX0mifi9L+1SQ0PluQLPcKyKyikCi52ALC9sjPnvYDGmfDliXJEkPs8SadHrD5DYmOHO8FgDRm8Ge8960Xq0VG9FeuC9U5/KqFhaYv3g0VmCJy3g6AM=
Message-ID: <6bffcb0e05092016291f14c6e2@mail.gmail.com>
Date: Wed, 21 Sep 2005 01:29:48 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc2 compilation warnings (gcc-4.1-20050917)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It maybe a bit off topic, but I just tried to compile latest
2.6.14-rc2 with new gcc-4.1 (stage 3:
http://gcc.gnu.org/develop.html#stage3). I have noticed some warnings
(in example):

usr/initramfs_data.S: Assembler messages:
usr/initramfs_data.S:1: Warning: line numbers must be positive; line
number 0 rejected

This maybe a gcc issue.

---

kernel/sched.c: In function 'yield':
kernel/sched.c:4069: warning: value computed is not used

void __sched yield(void)
{
	set_current_state(TASK_RUNNING);
	sys_sched_yield();
}

I found this while googling: http://gcc.gnu.org/ml/gcc/1998-04/msg00810.html

What's wrong? TASK_RUNNING is definition from include/linux/sched.h

Full compilation log:
http://stud.wsi.edu.pl/~piotrowskim/research/linux/gcc-4.1-20050917/compilation_log.txt

Regards,
Michal Piotrowski
