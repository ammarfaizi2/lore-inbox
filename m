Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCHWiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUCHWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:38:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:57222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261380AbUCHWit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:38:49 -0500
Date: Mon, 8 Mar 2004 14:40:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent Reaim results
Message-Id: <20040308144050.1fe5976a.akpm@osdl.org>
In-Reply-To: <20040308083433.67485899.cliffw@osdl.org>
References: <20040308083433.67485899.cliffw@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white <cliffw@osdl.org> wrote:
>
> 
> Test results from the OSDL reaim test. 
> The -mm kernels now appear to be scaling a bit nice.
> I dunno why, but the 8-ways like -mm2 :)

I think your'e playing with my mind.

> The is the 'database' load, a mixture of IO and CPU activity.

What about file server load?

> 4-CPU  ( all AS )
> linux-2.6.3		5313.36		0.0
> 2.6.4-rc1		5218.87		-1.78
> 2.6.4-rc1-mm2		5391.00 	1.46

I spent a boring evening with the file server load on 4-way x86 with six
disks.  If I squinted at it hard enough I was able to discern a 1% slowdown
due to O_DIRECT-vs-buffered-fix.patch, but it was pretty thin.

I didn't test the database load.
