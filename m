Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUH3Wjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUH3Wjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUH3Wjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:39:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:17121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264704AbUH3Wjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:39:46 -0400
Date: Mon, 30 Aug 2004 15:39:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bob Bennett <Robert.Bennett2@ca.com>
Cc: apkm@osdl.org, linux-kernel@vger.kernel.org,
       kgem-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Kernel Generalized Event Management
Message-ID: <20040830153942.C1973@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>; from Robert.Bennett2@ca.com on Mon, Aug 30, 2004 at 06:06:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bob Bennett (Robert.Bennett2@ca.com) wrote:
> KGEM is available for download from http://sf.net/projects/kgem as a patch
> against kernel 2.6.8.1 and as a gzipped tar file containing the source and 
> documentation.  The components may be built either as kernel loadable modules
> or as part of the base.
> 
> I have included a hook plugin module designed to be used with an anti-virus
> realtime scanner application, whose purpose is to check files as they are 
> being opened or executed, to make sure they are not infected.  This module 
> defines five events; open, execve, close, fork, and exit.  It registers with
> LSM to get control and generate these events.

So, why so much patch to do what's already available in the kernel?  With
LSM, plus audit, you can generate events that userspace can consume via
netlink w/out this /proc stuff, and sys_call_table symbol lookup stuff,
the kernel hooks, etc.

How about starting by showing exactly what pieces are missing in the
kernel?  This looks like things that can easily be done using existing
infrastructure.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
