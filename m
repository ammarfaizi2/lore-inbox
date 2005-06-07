Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVFGPtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVFGPtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVFGPtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:49:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57009 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261909AbVFGPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:49:19 -0400
Date: Tue, 7 Jun 2005 10:48:46 -0500
From: Dean Nelson <dcn@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, linux-ia64@vger.kernel.org, linux-altix@sgi.com,
       edwardsg@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       anton.wilson@camotion.com
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
Message-ID: <20050607154846.GA1253@sgi.com>
References: <1118112390.4533.10.camel@localhost.localdomain> <20050607053306.GA16181@elte.hu> <1118143504.4533.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118143504.4533.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 07:25:04AM -0400, Steven Rostedt wrote:
> On Tue, 2005-06-07 at 07:33 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > I tested the patch on an SMP machine where MAX_RT_PRIO = 100 and 
> > > MAX_USER_RT_PRIO = 99. Without the patch, the system crashes with a 
> > > reboot.
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> If this patch does go in, then xpc_activating in
> arch/ia64/sn/kernel/xpc_main.c (from rc6) also needs to use MAX_RT_PRIO
> instead of MAX_USER_RT_PRIO. Unless it is OK that it runs lower in
> priority than other kernel threads.

You are correct xpc_activating() needs to be changed to use MAX_RT_PRIO.
So please do add that change to your patch.

Thanks,
Dean

