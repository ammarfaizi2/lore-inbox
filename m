Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWGYCcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWGYCcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGYCcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:32:07 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:61145 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932412AbWGYCcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:32:06 -0400
Date: Tue, 25 Jul 2006 11:34:46 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060725113446.09eda7bb.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060724190626.75b71d02.akpm@osdl.org>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060725105339.e8c25775.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724190626.75b71d02.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 19:06:26 -0700
Andrew Morton <akpm@osdl.org> wrote:
> > but it was not very good because 
> > proc_pid_readdir() has to traverse all pids, not tgids.
> 
> You mean "all tgids, not pids".
> 
Ah, sorry. Precisely, traverse all pids and choose tgids from them because
pid_hash[] remembers all pids.


> > So, I had to access
> > task_struct of the pid. I wanted to avoid to access task struct itself,
> 
> Why do you wish to avoid accessing the task_struct?
> 
I thought accessing all task struct at random is heavy work and have to
up and down rcu_read_lock thousands of times.
I'm sorry if my thought is not problem.

Thanks,
-Kame

