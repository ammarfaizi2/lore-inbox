Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbULHGIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbULHGIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbULHGIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:08:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:4274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262037AbULHGH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:07:57 -0500
Date: Tue, 7 Dec 2004 22:07:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Subject: Re: oops in proc_pid_stat() on task->real_parent?
Message-ID: <20041207220753.E469@build.pdx.osdl.net>
References: <1102467332.19465.197.camel@localhost> <20041207220016.6917ee6f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041207220016.6917ee6f.akpm@osdl.org>; from akpm@osdl.org on Tue, Dec 07, 2004 at 10:00:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> yup, we fixed that one.

I thought the same thing, but this oops is from proc_pid_stat, not
proc_pid_status.  The code is now in do_task_stat(), and the oops is
within the orignal tasklist lock (instead of dropping and reaquiring the
lock).  So, might be fixed, but if so, I think for a different reason.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
