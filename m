Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWCUN7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWCUN7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWCUN7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:59:17 -0500
Received: from www.osadl.org ([213.239.205.134]:22937 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030387AbWCUN7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:59:17 -0500
Message-ID: <442006AE.8030706@tglx.de>
Date: Tue, 21 Mar 2006 14:59:10 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Serge Noiraud <serge.noiraud@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
References: <20060320085137.GA29554@elte.hu> <200603211430.29466.Serge.Noiraud@bull.net>
In-Reply-To: <200603211430.29466.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC, I've seen this error already in a post for 2.6.16-rc6-rt1

> *** Warning: "mutex_destroy" [fs/xfs/xfs.ko] undefined!

mutex_destroy isn't defined for CONFIG_PREEMPT_RT.

In the past mutex_destroy was defined in fs/xfs/linux_26/mutex.h, but
this has been moved. Have a look at: include/linux/mutex-debug.h,
kernel/mutex-debug.c, include/linux/mutex.h


JAN
