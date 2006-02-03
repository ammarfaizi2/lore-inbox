Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWBCTJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWBCTJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWBCTJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:09:14 -0500
Received: from pat.uio.no ([129.240.130.16]:9681 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422675AbWBCTJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:09:13 -0500
Subject: Re: Stale NFS File Handle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0970A93@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0970A93@chicken.machinevisionproducts.com>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 14:09:04 -0500
Message-Id: <1138993744.7861.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.819, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 10:05 -0800, Brian D. McGrew wrote:
> Good morning all (kind of a long winded mail, please have patience!)
> 
> I've got an FC3 server running a 2.6.9 kernel and sharing about 500GB of
> disk space on a RAID5 array via NFS.  This box has been running fine for
> over a year now but in the last three weeks or so I'm seeing a ton of
> Stale NFS File Handle errors; especially in my overnight builds.
> 
> Most of my clients are FC3 and a couple of Solaris boxes running a stock
> configuration.  All we're doing is serving up NFS and compiling with
> GCC.  We're seeing this error more and more and the harder I try to
> track it down, the more we're seeing it (ok, maybe that's my
> imagination).
> 
> I'm guessing that the problem has to be somewhere in the FC3 server
> because I've still got some Solaris NFS servers that have been running
> for years with no problems.
> 
> What should I be looking for in tracking this error down?  Should I
> upgrade my kernel?  Should I throw away FC3 and go to Enterprise Linux?
> I'm at the end of my rope here because this is now causing a major set
> back to our development team!

Kernels prior to 2.6.12 (if memory serves me correctly) had a series of
errors in the code that converts filehandles into valid dentries on the
server. Upgrading to the FC4 kernel, which I believe to be 2.6.14 based,
is therefore very likely to solve your problem.

Cheers,
  Trond

