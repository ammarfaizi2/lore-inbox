Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUJOCLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUJOCLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUJOCLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:11:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:35741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268128AbUJOCLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:11:03 -0400
Date: Thu, 14 Oct 2004 19:09:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041014190910.79cb2665.akpm@osdl.org>
In-Reply-To: <1097805925.22673.70.camel@localhost.localdomain>
References: <20041004020207.4f168876.akpm@osdl.org>
	<200410051607.40860.dominik.karall@gmx.net>
	<1097804285.22673.47.camel@localhost.localdomain>
	<20041014184427.65d75324.akpm@osdl.org>
	<1097805925.22673.70.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> > We were getting warnings from somewhere or other due to smp_processor_id()
>  > within preemptible code - I don't recall the callsite.
> 
>  That's weird, but implies bogosity in the caller.  Covering it up like
>  this is not necessarily a win.

umm.

	ip_conntrack_cleanup
	->ip_ct_selective_cleanup
	  ->death_by_timeout
	    ->CONNTRACK_STAT_INC

is one route.
