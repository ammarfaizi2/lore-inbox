Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUGNArD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUGNArD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUGNArD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:47:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:6325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266115AbUGNArB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:47:01 -0400
Date: Tue, 13 Jul 2004 17:45:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713174513.25288ffe.akpm@osdl.org>
In-Reply-To: <20040714004001.GR974@dualathlon.random>
References: <20040713213847.GH974@dualathlon.random>
	<20040713145424.1217b67f.akpm@osdl.org>
	<20040713220103.GJ974@dualathlon.random>
	<20040713152532.6df4a163.akpm@osdl.org>
	<20040713223701.GM974@dualathlon.random>
	<20040713154448.4d29e004.akpm@osdl.org>
	<20040713225305.GO974@dualathlon.random>
	<20040713160628.596b96a3.akpm@osdl.org>
	<20040713231803.GP974@dualathlon.random>
	<20040713163236.0dbf3872.akpm@osdl.org>
	<20040714004001.GR974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I'm missing where cond_resched is needed inside lock_kernel though,

Anywhere where we do lots of work inside lock_kernel().  Various ioctls and
ext3 journal recovery are instances.
