Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRKMQ4x>; Tue, 13 Nov 2001 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276761AbRKMQ4n>; Tue, 13 Nov 2001 11:56:43 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:16021 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276759AbRKMQ4b>; Tue, 13 Nov 2001 11:56:31 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200111131656.fADGuWn06695@devserv.devel.redhat.com>
Subject: Re: [PATCH] Ramdisk ioctl bug fix, kernel 2.4.14
To: mhteas@btech.com (Malcolm H. Teas)
Date: Tue, 13 Nov 2001 11:56:32 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3BF12860.1050302@btech.com> from "Malcolm H. Teas" at Nov 13, 2001 08:04:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most disk devices can't change their size with a few commands as a ram disk can 
> as it's a physical constant.  Ram disks are virtual so their size is whatever 
> the user specifies, with a kernel configured upper limit.  I argue that the size 
> is the allocated amount, not the upper limit.

I think your problem is that you are querying the disk to ask it the file
system size ? If so you asked the wrong code
