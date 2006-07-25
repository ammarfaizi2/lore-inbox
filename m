Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWGYCFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWGYCFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWGYCFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:05:46 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:42649 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932162AbWGYCFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:05:45 -0400
Date: Tue, 25 Jul 2006 11:08:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060724184847.3ff6be7d.pj@sgi.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 18:48:47 -0700
Paul Jackson <pj@sgi.com> wrote:

> Another possibility (perhaps a really stupid idea ;) would be to
> snapshot the list of pids on the open, and let the readdir() just
> access that fixed array.
> 
> The kernel/cpuset.c cpuset_tasks_open() routine that displays the
> pids of tasks in a cpuset (the per-cpuset 'tasks' file) does this.
> 
Oh. thank you for informing :) I don't know about that.
I'll look into.

> Then the seek and read and such semantics are nice and stable and
> simple.
> 
yes...
I think snapshot at open() is okay.

-Kame

