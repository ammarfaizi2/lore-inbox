Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290520AbSBKVvg>; Mon, 11 Feb 2002 16:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290534AbSBKVva>; Mon, 11 Feb 2002 16:51:30 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:9370 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S290523AbSBKVvN>; Mon, 11 Feb 2002 16:51:13 -0500
Date: Tue, 12 Feb 2002 07:50:48 +1100
From: Anton Blanchard <anton@samba.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: thread_info implementation
Message-ID: <20020211205048.GA5401@krispykreme>
In-Reply-To: <3C6832CC.D9D27F2F@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6832CC.D9D27F2F@linux-m68k.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> why have thread_info and task_struct to be two different pointers? I'd
> prefer two keep one pointer, through everything is accessed, that means
> thread_info would be part of task_struct.

Paul and I talked about this and we guessed it is an intel hack so they
can use the "mask the stack pointer to get to struct thread_info" trick.

On archs where we use a register to point to current I cant see why we
need this thread_info junk. I'd be happy if we could put it all in the
task struct for non intel.

Anton
