Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUJFPz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUJFPz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUJFPz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:55:29 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38799 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269296AbUJFPzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:55:16 -0400
Subject: Re: Proper use of daemonize()?
From: Lee Revell <rlrevell@joe-job.com>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <030601c4abb7$af573770$294b82ce@stuartm>
References: <030601c4abb7$af573770$294b82ce@stuartm>
Content-Type: text/plain
Message-Id: <1097078113.1903.61.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 11:55:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 11:18, Stuart MacDonald wrote:
> I've been looking at the kernel threads that use daemonize() and have
> some questions about the proper use of this call:
> 
> 1: Some threads use the lock_kernel() calls around the daemonize()
> call. Is this necessary?

It's only necessary if you can't be bothered to do proper locking. 
Probably that code is old and someone did not have time to implement
correct locking to make it work on SMP so just threw lock/unlock kernel
around it.

>  I thought the BKL was phasing out.
> 

Well, it's not going to phase itself out ;-)  But, patches that
introduce new uses of the BKL will almost certainly go to /dev/null.

Lee

