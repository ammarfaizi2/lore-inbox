Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263163AbTDBVkS>; Wed, 2 Apr 2003 16:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263164AbTDBVkS>; Wed, 2 Apr 2003 16:40:18 -0500
Received: from [12.47.58.55] ([12.47.58.55]:23281 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263163AbTDBVkR>;
	Wed, 2 Apr 2003 16:40:17 -0500
Date: Wed, 2 Apr 2003 13:51:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: subsystem crashes reboot system?
Message-Id: <20030402135104.4b1acadf.akpm@digeo.com>
In-Reply-To: <200304021149.36511.rmiller@duskglow.com>
References: <200304021149.36511.rmiller@duskglow.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2003 21:51:36.0575 (UTC) FILETIME=[0892E0F0:01C2F962]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> wrote:
>
> Since this was an assertion that failed, one would think that bringing the 
> system down automatically in an orderly - then, if that fails, disorderly - 
> fashion would be possible.

The way to handle this is to make arch/i386/kernel/traps.c:die() optionally
call panic() rather than do_exit().

It makes sense.  It does mean that we now have zero chance of the diagnostic
info making it to the system logs.

