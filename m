Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbTDBWC4>; Wed, 2 Apr 2003 17:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbTDBWC4>; Wed, 2 Apr 2003 17:02:56 -0500
Received: from [12.47.58.55] ([12.47.58.55]:15606 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263174AbTDBWCz>;
	Wed, 2 Apr 2003 17:02:55 -0500
Date: Wed, 2 Apr 2003 14:13:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: subsystem crashes reboot system?
Message-Id: <20030402141342.27c28d01.akpm@digeo.com>
In-Reply-To: <200304021551.04659.rmiller@duskglow.com>
References: <200304021149.36511.rmiller@duskglow.com>
	<20030402135104.4b1acadf.akpm@digeo.com>
	<200304021551.04659.rmiller@duskglow.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2003 22:14:15.0223 (UTC) FILETIME=[32641C70:01C2F965]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> wrote:
>
> Any chance of making the dying thread sleep just long enough for syslogd to 
> write it out to the file, then panic?  Since it's an assertion, we have a 
> little more leeway then in a page fault OOPS, for example.
> 

Yes, that would probably be OK.  It won't make anything worse than it
already is.

hm, the kernel used to panic if schedule() was called from in_interrupt(),
but that seems to have been taken out.   It's easy enough (and free) to
put back in.
