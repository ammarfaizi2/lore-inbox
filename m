Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWBRKqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWBRKqB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 05:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWBRKqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 05:46:01 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60294 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751161AbWBRKqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 05:46:00 -0500
Date: Sat, 18 Feb 2006 16:14:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dada1@cosmosbay.com
Subject: Re: [PATCH 2/2] fix file counting
Message-ID: <20060218104454.GR29846@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060217154147.GL29846@in.ibm.com> <20060217154337.GM29846@in.ibm.com> <20060217154626.GN29846@in.ibm.com> <20060218010414.1f8d6782.akpm@osdl.org> <20060218092517.GP29846@in.ibm.com> <20060218014529.5f160d39.akpm@osdl.org> <20060218100629.GQ29846@in.ibm.com> <20060218021022.6b5fe1ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218021022.6b5fe1ba.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 02:10:22AM -0800, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> >  On Sat, Feb 18, 2006 at 01:45:29AM -0800, Andrew Morton wrote:
> 
> Look closer ;)
> 
> 	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
> 		/*
> 		 * percpu_counters are inaccurate.  Do an expensive check before
> 		 * we go and fail.
> 		 */
> 		if (percpu_counter_sum(&nr_files) >= files_stat.max_files)
> 			goto over;
> 	}

Ah, that check is not relevant for priviledged users anyway. That
means I should just continue doing where my mind is at the moment - running
the weekend errands :) And not look at code.

Thanks
Dipankar
