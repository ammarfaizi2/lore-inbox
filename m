Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUEVTii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUEVTii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUEVTii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:38:38 -0400
Received: from defout.telus.net ([199.185.220.240]:5763 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S261862AbUEVTig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:38:36 -0400
Subject: Re: nvidia not working on 2.6.6-bk5+ (x86-64) ?
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085254940.3934.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 22 May 2004 13:42:20 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  In general LKML is for Linux kernel goodness, and since NVIDIA is a
private binary-only driver, most people would prefer you post the bug on
an NVIDIA list.  But, having already started this post... you might
check to see if RHGB is on your kernel boot line.  I am running FC2 but
noticed that even test versions of FC (with non-standard/more modern
kernels) will kill the X server if you use the RedHat graphical boot
(rhgb) on the kernel line.  In my case, I would get the nvidia splash
screen, and the graphical boot window showing the system booting,
followed by a crash when the system tried to start X. I would get a
white screen and no response where the graphical greeter/login is
supposed to be.  Getting rid of rhgb got rid of the problem.  I suspect
a race between X wanting to start and rhgb wanting to stop (and not all
data structures are free yet).  I don't think this problem is related to
the transition between XFree86 and X.org.  If this 'fix' doesn't apply
to you, please ignore it.
Thanks,

Bob

