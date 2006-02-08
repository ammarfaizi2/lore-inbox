Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWBHQk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWBHQk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWBHQk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:40:29 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51600 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030587AbWBHQk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:40:28 -0500
Date: Wed, 8 Feb 2006 22:09:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 03/10] s390: earlier initialization of cpu_possible_map
Message-ID: <20060208163943.GA24115@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060208123337.GD1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208123337.GD1656@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:33:37PM +0100, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Initiliazing of cpu_possible_map was done in smp_prepare_cpus which is
> way too late. Therefore assign a static value to cpu_possible_map, since
> we don't have access to max_cpus in setup_arch.

With this and Ivan's alpha fix, it should now be safe to use
for_each_cpu() in vfs_caches_init() path as done by the merged
patch from Eric. I have done a quick check and couldn't find
any other late initialization of cpu_possible_map, but arch
maintainers probably can say for sure.

Thanks
Dipankar
