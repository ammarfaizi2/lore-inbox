Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVCaUWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVCaUWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCaUWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:22:50 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:19098 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261759AbVCaUWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:22:48 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331174927.GA11483@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
	 <1112290916.12543.19.camel@localhost.localdomain>
	 <20050331174927.GA11483@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 31 Mar 2005 15:22:36 -0500
Message-Id: <1112300556.12543.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 19:49 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Oh, and did your really want to assign debug = .1?
> 
> > -	.debug = .1, .file = __FILE__, .line = __LINE__
> > +	.debug = 1, .file = __FILE__, .line = __LINE__
> 
> doh - indeed. This means rwlocks were nondebug all along? Ouch. I've 
> uploaded -42-08 with the fix.

I noticed it because starting with V0.7.41-25 (although I only actually
noticed it with 42-07) not only were they nondebug, but they also didn't
have any priority inheritance.

-- Steve


