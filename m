Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUDQXVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbUDQXVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:21:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:32910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264066AbUDQXVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:21:44 -0400
Date: Sat, 17 Apr 2004 16:21:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Singer <elf@buici.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, elf@buici.com
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-Id: <20040417162125.3296430a.akpm@osdl.org>
In-Reply-To: <20040417212958.GA8722@flea>
References: <20040417193855.GP743@holomorphy.com>
	<20040417212958.GA8722@flea>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>
>  I'd say that there is no statistically significant difference between
>  these sets of times.  However, after I've run the test program, I run
>  the command "ls -l /proc"
> 
>  				 swappiness
>  			60 (default)		0
>  			------------		--------
>  elapsed time(s)		18			1
>  			30			1
>  			33			1

How on earth can it take half a minute to list /proc?

>  This is the problem.  Once RAM fills with IO buffers, the kernel's
>  tendency to evict mapped pages ruins interactive performance.

Is everything here on NFS, or are local filesystemms involved?  (What does
"mount" say?)
