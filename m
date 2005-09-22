Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVIVTX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVIVTX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVIVTX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:23:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:50887 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751159AbVIVTX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:23:59 -0400
Date: Fri, 23 Sep 2005 00:48:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050922191805.GB4729@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20050922182719.GA4729@in.ibm.com> <4332FFF5.5060207@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332FFF5.5060207@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 01:03:17PM -0600, Christopher Friesen wrote:
> Dipankar Sarma wrote:
> 
> >This can happen if a task runs for too long inside the kernel
> >holding up context switches or usermode code running on that
> >cpu. The fact that RCU grace period eventually happens
> >and the dentries are freed means that something intermittently
> >holds up RCU. Is this 2.6.10 vanilla or does it have other
> >patches in there ?
> 
> The 2.6.10 was modified.  All the results with the dcache debugging 
> patch applied were from vanilla 2.6.14-rc2.
> 
> It's perfectly repeatable as well...every single time I run "rename14" 
> the OOM killer kicks in.

Can you look at that each cpu is running (backtrace) using
sysrq ? That may tell us what is holding up RCU. I will look
at it myself later.

Thanks
Dipankar
