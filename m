Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVCUBAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVCUBAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVCUBAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 20:00:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:21128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261435AbVCUBAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 20:00:36 -0500
Date: Sun, 20 Mar 2005 17:00:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
Message-Id: <20050320170016.37a4b5f8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503201641230.2021@server.graphe.net>
References: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
	<20050320153446.32a9215a.akpm@osdl.org>
	<Pine.LNX.4.58.0503201641230.2021@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> On Sun, 20 Mar 2005, Andrew Morton wrote:
> 
> > "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> > >
> > > We did exactly the same thing about 10 months back.  Nice to
> > > see that independent people came up with exactly the same
> > > solution that we proposed 10 months back.
> >
> > Well the same question applies.  Christoph, which code is calling
> > del_timer_sync() so often that you noticed?
> 
> Ummm. I have to ask those who brought this to my attention. Are you
> looking for the application under which del_timer_sync showed up in
> profiling or the kernel subsystem?

I was wondering which part of the kernel was hammering del_timer_sync() so
hard.  I guess we could work that out from a description of the workload.

