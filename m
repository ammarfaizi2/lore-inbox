Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSKOR01>; Fri, 15 Nov 2002 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKOR01>; Fri, 15 Nov 2002 12:26:27 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:21234 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S266552AbSKOR00>; Fri, 15 Nov 2002 12:26:26 -0500
Date: Fri, 15 Nov 2002 12:33:22 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Kernel Janitors Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] use thread_info.h in uaccess.h
Message-ID: <20021115123322.A7422@redhat.com>
References: <20021115113223.GN18180@conectiva.com.br> <20021115164927.G20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115164927.G20070@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Fri, Nov 15, 2002 at 04:49:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 04:49:27PM +0000, Matthew Wilcox wrote:
> 
> While we're janitoring headers...
> 
> This patch removes all the wait_queue handling code from sched.h and puts
> it in wait.h with the rest of the wait_queue handling code.  Note that
> sched.h must continue to include wait.h for the wait_queue_head_t embedded
> in struct task.  However there may be files which only need wait.h now.

Move the typedef into linux/types.h and that problem goes away.

		-ben
