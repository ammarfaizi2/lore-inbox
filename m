Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266297AbUA3Ah3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUA3Ah3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:37:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:12683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266297AbUA3Ah2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:37:28 -0500
Date: Thu, 29 Jan 2004 16:38:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Curt Hartung" <curt@northarc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raw devices broken in 2.6.1?
Message-Id: <20040129163852.4028c689.akpm@osdl.org>
In-Reply-To: <01c501c3e6b9$67225f70$0700000a@irrosa>
References: <01c501c3e6b9$67225f70$0700000a@irrosa>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Curt Hartung" <curt@northarc.com> wrote:
>
> New to the list, checked the FAQ and nothing on this. I'm using raw devices
> for a large database application (highwinds-software) and under 2.4 it runs
> fine, but under 2.6 I get: Program terminated with signal 25, File size
> limit exceeded. (SIGXFSZ) As soon as it tries to grow the raw device pase 2G
> (might be 4G, I'll go back and check)
> 
> ulimit reports: file size (blocks)          unlimited
> but running the process as root and setrlimit RLIMIT_FSIZE to RLIM_INFINITY
> just to be sure yields the same result.

Possibly whatever version of 2.4 you're using forgot to check for
O_LARGEFILE.  But the code looks to be OK.

> I can easily provide a short test program to trigger it, the call I'm using
> is pwrite64(...);

Yes, please.
