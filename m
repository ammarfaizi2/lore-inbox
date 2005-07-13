Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVGMAPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVGMAPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVGMAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:06:32 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:43161 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262534AbVGMAFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:05:07 -0400
Subject: Re: realtime-preempt + reiser4?
From: Steven Rostedt <rostedt@goodmis.org>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <42D45438.6040409@gmail.com>
References: <42D4201A.9050303@gmail.com>
	 <1121198723.10580.10.camel@mindpipe>  <42D45438.6040409@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 20:04:59 -0400
Message-Id: <1121213099.3548.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 19:37 -0400, Keenan Pepper wrote:

> 
> I naively changed these two calls from
> 
> init_MUTEX_LOCKED(&name);
> 
> to
> 
> init_MUTEX(&name);
> down(&name);
> 
> but I'm not sure if that's right. I guess I'll see when I try to boot it!

No, since it probably wont be "uped" by the same process.  So what you
want to do is change the definition of name from semaphore to
compat_semaphore, and keep it as init_MUTEX_LOCKED.  And please send
patches to Ingo (I've included him on CC).  Also include Ingo on all RT
related issues, since he is the one maintaining the patch.

Thanks,

-- Steve


