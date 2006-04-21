Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWDUIzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWDUIzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDUIzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:55:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbWDUIzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:55:11 -0400
Date: Fri, 21 Apr 2006 01:54:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@namei.org>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-Id: <20060421015412.49a554fa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604210322110.21429@d.namei>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	<Pine.LNX.4.64.0604210322110.21429@d.namei>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:
>
> On Fri, 21 Apr 2006, Daniel Walker wrote:
> 
> > 	I included a patch , not like it's needed . Recently I've been
> > evaluating likely/unlikely branch prediction .. One thing that I found 
> > is that the kfree function is often called with a NULL "objp" . In fact
> > it's so frequent that the "unlikely" branch predictor should be inverted!
> > Or at least on my configuration. 
> 
> It would be helpful to collect some stats on this so we can look at the 
> ratio.
> 

Yes, kfree(NULL) is supposed to be uncommon.  If someone's doing it a lot
then we should fix up the callers.
