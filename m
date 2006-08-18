Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWHRWnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWHRWnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWHRWnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:43:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422636AbWHRWnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:43:05 -0400
Date: Fri, 18 Aug 2006 15:41:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       Kai Petzke <wpp@marie.physik.tu-berlin.de>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
Message-Id: <20060818154151.e92d4246.akpm@osdl.org>
In-Reply-To: <44E63476.201@garzik.org>
References: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org>
	<44E63476.201@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 17:43:18 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Stern wrote:
> > I'd like to lodge a bitter complaint about the return codes used by 
> > queue_work() and related functions:
> > 
> > 	Why do the damn things return 0 for error and 1 for success???
> > 	Why don't they use negative error codes for failure, like 
> > 	everything else in the kernel?!!
> 
> It's a standard programming idiom:  return false (0) for failure, true 
> (non-zero) for success.  Boolean.
> 
> Certainly the kernel often uses the -errno convention, but it's not a rule.
> 

The predominant convention in the kernel is 0==success and I do think that
the change which Alan suggests would be kinder to the
principle-of-least-surprise.

But if you're going to change the function's return conventions, please
also rename the function.

