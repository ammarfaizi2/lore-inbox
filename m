Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTKFEgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 23:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTKFEgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 23:36:48 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:28995 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263357AbTKFEgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 23:36:47 -0500
Date: Wed, 5 Nov 2003 20:36:41 -0800
To: Antonio Vargas <wind@cocodriloo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DMESG] cpumask_t in action
Message-ID: <20031106043641.GA26345@sgi.com>
Mail-Followup-To: Antonio Vargas <wind@cocodriloo.com>,
	linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB58023A6@scsmsx401.sc.intel.com> <20031105232438.GA24817@sgi.com> <20031105234231.GA16122@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105234231.GA16122@wind.cocodriloo.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 12:42:31AM +0100, Antonio Vargas wrote:
> > As for the dentry and inode-cache tables, yes they're probably too big,
> > and they're also allocated on node 0 rather than being spread out.
> > 
> 
> Jesse, what about making hash_size = scale * log(mem_size), so that the
> tables are not scaled too high on your very-high-end boxes? ;)

Sounds good to me, should we change the callers in vfs_caches_init() or
revisit each individual hash to see what size makes sense?

Thanks,
Jesse
