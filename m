Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267741AbUG3RA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267741AbUG3RA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267744AbUG3RA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:00:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267746AbUG3RAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:00:53 -0400
Date: Fri, 30 Jul 2004 13:30:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Klaus Dittrich <kladit@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040730163007.GA2931@logos.cnet>
References: <20040726150615.GA1119@xeon2.local.here> <20040729140743.170acb3e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729140743.170acb3e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 02:07:43PM -0700, Andrew Morton wrote:
> kladit@t-online.de (Klaus Dittrich) wrote:
> >
> > >Can you narrow the onset of the problem down to any particular kernel
> > >snapshot?
> > 
> > Did it and here is the answer.
> > 
> > kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
> > kernels starting with 2.6.7-bk8 did not.
> 
> I can reproduce this oom btw.  Am (very, very slowly) working out what's
> causing it.  It's unrelated to the vfs-cache-pressure patch.  I'd hope to
> have it fixed up for 2.6.8. 

Odd, because the only thing I can see which affects dcache related code
between -bk7 and -bk8 is the vfs-cache-pressure patch.

What are the exact steps you're using to reproduce the leak?

And where do you think the problem lies?
