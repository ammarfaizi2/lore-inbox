Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWGGW7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWGGW7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWGGW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:59:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932272AbWGGW7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:59:33 -0400
Date: Fri, 7 Jul 2006 16:00:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process events: Fix biarch compatibility
Message-Id: <20060707160000.45b9a9f0.akpm@osdl.org>
In-Reply-To: <1152308332.21787.2178.camel@stark>
References: <1152308332.21787.2178.camel@stark>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley <matthltc@us.ibm.com> wrote:
>
> Andrew, I'd like to revise my request and shoot for eventual inclusion
> in 2.6.18 if it's not too much to ask. What do you think?

I'm not sure what you're referring to here.

The per-task-delay-accounting patches I'd like to get into 2.6.18, yes. 
We've been dicking around for *years* with enhanced system accounting
requirements and we now seem to have a roughly-agreed-upon way of doing
that.  I think we just need to get it in there and get people using it for
their various accounting needs.  I was planning on getting all this into
-rc1 but then we got derailed by the 1000-cpus-doing-1000-exits-per-second
problem.

The task-watchers patches I really like - it fixes the problem of more and
more subsystems adding their little own little hooks all into the same
places.  But I think it's much less urgent than per-task-delay-accounting
and, given that (afaik) we haven't yet resolved whether task-watchers will
use a single notifier chain or one per event, I'm inclined to hold that
back until 2.6.19.

