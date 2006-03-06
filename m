Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWCFEdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWCFEdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 23:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWCFEdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 23:33:37 -0500
Received: from mail.suse.de ([195.135.220.2]:41089 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750971AbWCFEdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 23:33:36 -0500
From: Neil Brown <neilb@suse.de>
To: Iain William Wiseman <iwiseman@eservglobal.com>
Date: Mon, 6 Mar 2006 15:32:32 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17419.47968.756969.377865@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops [NFS server crash]
In-Reply-To: message from Iain William Wiseman on Monday March 6
References: <440B4FE3.4000809@eservglobal.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 6, iwiseman@eservglobal.com wrote:
> Hi,
> 
> Hope I am sending this to the right place. Let me know if you need any 
> other infor

It's as good a place as any - though putting something more
descriptive like "NFS server crash" might make it less likely to all
through the cracks..


> 
> The machine crashed while trying to use NFS
> 
> *Kernel Version*
> Linux version 2.6.15.4 (root@denise.wiseman.com) (gcc version 4.0.0 
> 20050519 (Red Hat 4.0.0-8)) #1 Sat Feb 25 21:23:05 NZDT 2006
> 

This is a vanilla 2.6.15.4 is it?  No extra patches?

I haven't tried to duplicate the problem yet (my test machine is busy)
but it is very hard to see this happening unless the 'lock_kernel'
lock stopped working.

It looks from the logs like there were two attempts to start the nfs
server, the first one simply failed, the second caused the oops.  Is
that correct?

The reason the first attempt failed is that 'portmap' appear to not be
running. 

The reason for the oops is the interesting one for me.  I don't think
these is any extra information you can provide other than answers to
the above questions.

I'll try to reproduce it.

Thanks for the report.

NeilBrown
