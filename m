Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWAIUXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWAIUXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWAIUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:23:13 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:47491 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751316AbWAIUXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:23:11 -0500
Date: Mon, 9 Jan 2006 21:23:27 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20060109212327.2e0ca6b7@localhost>
In-Reply-To: <20060109210035.3f6adafc@localhost>
References: <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
	<20060101123902.27a10798@localhost>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
	<20060109210035.3f6adafc@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006 21:00:35 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> I don't know how can "nicksched" keep transcode priority always to 40
> even when I'm running the DD test... I should retry and see.

I was wrong... the interfering effect is here also with nicksched.

The problem is that Linux is smarter than me --> sometimes I forget the
effect of the disk-cache ;)

For the DD test I always umount/(re)mount the partition where the
BIGFILE is stored to discard the associated cache... but I've forgotten
to do the same for the file that transcode is reading from ;)

-- 
	Paolo Ornati
	Linux 2.6.15-plugsched on x86_64
