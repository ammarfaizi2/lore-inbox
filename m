Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWACVfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWACVfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWACVfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:35:01 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:36548 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964940AbWACVe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:34:59 -0500
Date: Tue, 3 Jan 2006 13:34:48 -0800
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom-killer causes lockups in cpuset_excl_nodes_overlap()
Message-Id: <20060103133448.7530f879.pj@sgi.com>
In-Reply-To: <20051228004026.72F3474005@sv1.valinux.co.jp>
References: <20051228004026.72F3474005@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KUROSAWA Takahiro wrote:
>
> The oom-killer causes lockups because it calls
> cpuset_excl_nodes_overlap() with tasklist_lock read-locked.
> cpuset_excl_nodes_overlap() gets cpuset_sem (or callback_sem in
> later linux versions) semaphore, which might_sleep even if the
> semaphore could be down without sleeping.

Thank-you for catching this.  My apologies for not responding sooner.
I was off the air for a week.  I will look at this now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
