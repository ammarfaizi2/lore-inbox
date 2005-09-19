Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVISWA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVISWA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVISWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:00:58 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:35418 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932466AbVISWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:00:57 -0400
X-IronPort-AV: i="3.97,123,1125896400"; 
   d="scan'208"; a="314743776:sNHT36731472"
Date: Mon, 19 Sep 2005 17:00:56 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Wu <flamingice@sourmilk.net>,
       Christoph Hellwig <hch@infradead.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       NetDev <netdev@vger.kernel.org>, ieee80211-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ieee80211 updates
Message-ID: <20050919220056.GB3916@lists.us.dell.com>
References: <4327625D.10808@linux.intel.com> <20050914105409.GB30645@infradead.org> <43285ADF.5030506@linux.intel.com> <20050917092846.GA14083@infradead.org> <432E1069.8010102@pobox.com> <20050919004450.16m2d1hn7les0o00@www.sourmilk.net> <432E4F7A.9040605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E4F7A.9040605@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 01:41:14AM -0400, Jeff Garzik wrote:
> Michael Wu wrote:
> >If it has a version, then only the maintainer can submit patches - 
> 
> False.  Presence of an optional label in source code files does not 
> change the fundamental rules of open source, or the processes 
> surrounding patch merging in the Linux kernel.  Anybody who feels the 
> version number should be changed is welcome to submit a patch.  And a 
> reviewer along the line is welcome to reject such a patch, if they think 
> it is unwarranted.
> 
> >otherwise the
> >version is useless for identifying what code you're running. (unless other
> 
> False.  We have plenty of examples of slower-moving drivers where 
> community consensus often dictates a version number change.


This is also the reason for the 'srcversion' field available in
modinfo.  This is a CRC across the source code for a given module (not
counting #include<*>, but counting #include "*").  The version field
may not change, but if anything really cares about a particular source
code copy, and that it hasn't been patched, but the version field not
updated, they can see that.

Thanks to Rusty for implementing this.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
