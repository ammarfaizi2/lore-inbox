Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTJJBUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTJJBUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:20:08 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:25932 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262719AbTJJBUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:20:05 -0400
Message-Id: <200310100124.h9A1OJ63012126@pasta.boston.redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Mika Penttila <mika.penttila@kolumbus.fi>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: My message of "Thu, 09 Oct 2003 21:01:11 EDT."
Date: Thu, 09 Oct 2003 21:24:19 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9-Oct-2003 at 21:1 EDT, Ernie Petrides wrote:

> Sorry I missed the discussion on the original changes.  Was there a
> race condition with another cpu gaining a reference in proc_pid_status()
> or access_process_vm() or something like that?  Is it possible to just
> use down_read(&old_mm->mmap_sem) and up_read(&old_mm->mmap_sem) inside
> exec_mmap() around the optimized call to exit_mmap() instead?

I meant down_write() and up_write().  (But I haven't evaluated whether
this would be feasible.)

Cheers.  -ernie
