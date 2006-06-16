Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWFPDEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWFPDEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWFPDEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:04:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35042 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750862AbWFPDEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:04:36 -0400
Date: Thu, 15 Jun 2006 22:04:32 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Mackerras <paulus@samba.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-ID: <20060616030432.GA18037@sergelap.austin.ibm.com>
References: <17553.56625.612931.136018@cargo.ozlabs.ibm.com> <1150419895.10290.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150419895.10290.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rusty Russell (rusty@rustcorp.com.au):
> On Fri, 2006-06-16 at 08:20 +1000, Paul Mackerras wrote:
> > Update stop_machine.c to spawn stop_machine as kthreads rather
> > than the deprecated kernel_threads.
> > 
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> kthread does a lot of stuff we don't need, and stop_machine is fairly
> special, low-level interface.
> 
> Seems like change for change's sake, to me, *and* it added more code
> than it removed.

So if kernel_thread is really going to be removed, how else should this
be done?  Just clone?

-serge
