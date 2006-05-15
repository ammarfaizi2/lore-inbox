Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWEOU64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWEOU64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWEOU64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:58:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21891 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964804AbWEOU6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:58:55 -0400
Date: Mon, 15 May 2006 14:01:40 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, ak@suse.de, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
Message-ID: <20060515210140.GZ25010@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <4460AC01.5020503@mbligh.org> <20060509150701.GA14050@infradead.org> <p73k68v4444.fsf@bragg.suse.de> <20060509152240.GA17837@infradead.org> <20060513183520.79a0d44e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513183520.79a0d44e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Also, note
> 
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/driver-core-add-sys-hypervisor-when-needed.patch
> 
> which creates the /sys/hypervisor directory.  With the expectation that
> _all_ hypervisorish subsystems will base their sysfs trees in there.

That's fine, Xen is currently using the same dir, so we just need to
adjust and select Kconfig.  There's some fallout as a a result (using
attrs directly vs spinning your own fs, for example), but it makes sense
to have common anchor in sysfs.

thanks,
-chris
