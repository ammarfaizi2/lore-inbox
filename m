Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTFDWYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTFDWYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:24:41 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46951 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264207AbTFDWYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:24:40 -0400
Message-ID: <3EDE74D1.767C6071@digeo.com>
Date: Wed, 04 Jun 2003 15:38:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.70-mm3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove page_table_lock from vma manipulations
References: <133290000.1054765825@baldur.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 22:38:10.0582 (UTC) FILETIME=[F9F4C360:01C32AE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> 
> After more careful consideration, I don't see any reasons why
> page_table_lock is necessary for dealing with vmas.  I found one spot in
> swapoff, but it was easily changed to mmap_sem.

What keeps the VMA tree consistent when try_to_unmap_one()
runs find_vma()?
