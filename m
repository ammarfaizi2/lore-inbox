Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSFTB3J>; Wed, 19 Jun 2002 21:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318082AbSFTB3J>; Wed, 19 Jun 2002 21:29:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:39165 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318080AbSFTB3I>; Wed, 19 Jun 2002 21:29:08 -0400
Date: Wed, 19 Jun 2002 21:29:09 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] (resend) credentials for 2.5.23
Message-ID: <20020619212909.A3468@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message didn't seem to get through the first time, so here it is 
again.  The patch is available for review at:

	http://www.kvack.org/~blah/v2.5.23-cred.diff

Several parts of the kernel need to obtain a reference to the 
credentials of a process: aio, nfs, dirty mmap writebacks to 
name a few.  Additionally, POSIX threads need to be able to share 
credentials between clones.  The patch below moves the credentials 
out of task_struct and into struct cred, which is reference 
counted.  It also adds support for CLONE_CRED which shares the 
credentials between threads.  Comments?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
