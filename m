Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTBYJAk>; Tue, 25 Feb 2003 04:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbTBYJAk>; Tue, 25 Feb 2003 04:00:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61057 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267854AbTBYJAj>;
	Tue, 25 Feb 2003 04:00:39 -0500
Date: Tue, 25 Feb 2003 14:59:45 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, ricklind@us.ibm.com
Subject: Re: [patch] Make diskstats per-cpu using kmalloc_percpu
Message-ID: <20030225092945.GC28052@in.ibm.com>
References: <20030225073654.GB28052@in.ibm.com> <20030224235610.67e38b34.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224235610.67e38b34.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:56:10PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> >
> > This version makes the disk stats on struct gendisk per-cpu.
> 
> Well OK, but it has lots of SCARY UPPER-CASE MACROS and disk_stat_inc(),
> disk_stat_dec() and disk_stat_sub() can all be defined in terms of
> disk_stat_add().
> 
> I did this to it:
> 

Ok, I don't have a preference one way or the other.  I used upper case 
since mib stats used upper case macros (it was that way before I 
twiddled with it).
I'll use lower case macros for the per partition stats too.

Thanks,
Kiran
