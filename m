Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWHVNgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWHVNgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHVNgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:36:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:19423 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932237AbWHVNgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:36:35 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <1156260209.6225.7.camel@Homer.simpson.net>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
	 <1156245036.6482.16.camel@Homer.simpson.net>
	 <20060822101028.GB5052@in.ibm.com>
	 <1156257674.4617.8.camel@Homer.simpson.net>
	 <1156260209.6225.7.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 15:45:05 +0000
Message-Id: <1156261506.6319.6.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 15:23 +0000, Mike Galbraith wrote:

> > > Can you try assigning (NUM_CPUS-1) cpus to "all" and give it a shot?
> > > Essentially you need to ensure that only tasks chosen by you are running in 
> > > cpus given to "all" and other child-cpusets under it.
> 
> With only cpu 1 in the cpuset, it worked.

P.S.  since it worked, (and there are other tasks that I assigned on it,
kthreads for example, I only assigned the one shell), I figured I'd try
adding the other cpu and see what happened.  It let me hot add cpu 0,
but tasks continue to be run only on cpu 1.

