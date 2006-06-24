Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWFXIP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWFXIP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFXIP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:15:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933259AbWFXIP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:15:57 -0400
Date: Sat, 24 Jun 2006 01:15:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Revised locking for taskstats interface
Message-Id: <20060624011551.1bcd4385.akpm@osdl.org>
In-Reply-To: <449CEB7C.3060004@watson.ibm.com>
References: <449C2A44.9000206@watson.ibm.com>
	<20060623233245.77f365bb.akpm@osdl.org>
	<449CEB7C.3060004@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 03:36:28 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> Andrew Morton wrote:
> 
> >On Fri, 23 Jun 2006 13:52:04 -0400
> >Shailabh Nagar <nagar@watson.ibm.com> wrote:
> >
> >  
> >
> >>Convert locking used within taskstats interface and delay accounting
> >>code to be more fine-grained.
> >>    
> >>
> >
> >This patch is based on
> >per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch,
> >which I've noted as `nacked' but didn't drop.
> >
> >So I guess that's now un-nacked?
> >  
> >
> Not in intent. This patch reverses all the changes made by that patch. 
> So effectively the previous patch is still nacked.
> However, I based this patch on the previous one because you hadn't 
> dropped the latter (so we're going round in circles !)
> 
> How about  I just send one patch that covers the whole locking thing ?
> 

Is OK - I'll concatenate these:

per-task-delay-accounting-taskstats-interface-fix-exit-race-in-per-task-delay-accounting.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-use-portable-cputime-api-in-__delayacct_add_tsk.patch
per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-fix-return-value-of-delayacct_add_tsk.patch
revised-locking-for-taskstats-interface.patch

into a single

per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch

