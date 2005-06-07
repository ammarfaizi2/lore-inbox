Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVFGTXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVFGTXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVFGTXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:23:31 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:9372 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261963AbVFGTX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:23:26 -0400
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
From: Steven Rostedt <rostedt@goodmis.org>
To: Dean Nelson <dcn@sgi.com>
Cc: mingo@elte.hu, linux-ia64@vger.kernel.org, linux-altix@sgi.com,
       edwardsg@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       anton.wilson@camotion.com
In-Reply-To: <20050607191001.GA8768@sgi.com>
References: <1118112390.4533.10.camel@localhost.localdomain>
	 <20050607053306.GA16181@elte.hu>
	 <1118143504.4533.21.camel@localhost.localdomain>
	 <20050607154846.GA1253@sgi.com>
	 <1118165519.5667.3.camel@localhost.localdomain>
	 <20050607191001.GA8768@sgi.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 07 Jun 2005 15:23:02 -0400
Message-Id: <1118172182.4972.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 14:10 -0500, Dean Nelson wrote:

> I just built and tested a kernel and xp/xpc/xpnet modules with your patch
> applied. It ran fine. The priorities of the xpc kthreads were correct.
> 
> Looks good to me.

Dean, 

If you can do me a favor, the way you really want to test this is by
changing MAX_USER_RT_PRIO to 99 and MAX_RT_PRIO to 
(MAX_USER_RT_PRIO+1).  This will make sure that the patch is working.
Your kernel thread should still run at priority 99. 

Check it with:  ps -eo pid,rtprio,comm

And grep for your thread name.

Thanks,

-- Steve


