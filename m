Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWDOU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWDOU7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWDOU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 16:59:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751471AbWDOU7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 16:59:41 -0400
Date: Sat, 15 Apr 2006 13:59:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.5 smp oops in find_or_create_page()
Message-Id: <20060415135912.7d123ded.akpm@osdl.org>
In-Reply-To: <20060415122717.GA1822@louise.pinerecords.com>
References: <20060415122717.GA1822@louise.pinerecords.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> wrote:
>
> One of our servers (a p3 smp machine) with 2.6.16.5 vanilla crashed last
>  night.  Kernel output enclosed below.
> 
>  -- 
>  Tomas Szepe <szepe@pinerecords.com>
> 
>  Apr 15 03:56:57 louise kernel: Unable to handle kernel paging request at virtual address 00008000

A single bit set in a well-tested codepath.  Most likely this is a hardware
failure (memory, DMA controller, dodgy power supply, etc).

You should run memtest86 on that machine for 24 hours.
