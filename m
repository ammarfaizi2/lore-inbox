Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTEMT0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTEMT0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:26:09 -0400
Received: from holomorphy.com ([66.224.33.161]:5820 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262263AbTEMT0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:26:08 -0400
Date: Tue, 13 May 2003 12:38:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, alexh@ihatent.com
Subject: Re: [PATCH] Re: 2.5.69-mm4 undefined active_load_balance
Message-ID: <20030513193847.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, alexh@ihatent.com
References: <20030512225504.4baca409.akpm@digeo.com> <87vfwf8h2n.fsf@lapper.ihatent.com> <20030513001135.2395860a.akpm@digeo.com> <87n0hr8edh.fsf@lapper.ihatent.com> <20030513085525.GA7730@hh.idb.hist.no> <20030513020414.5ca41817.akpm@digeo.com> <3EC0FB9E.8030305@aitel.hist.no> <20030513162711.GA30804@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513162711.GA30804@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 06:27:11PM +0200, Helge Hafting wrote:
> --- sched.h.orig        2003-05-13 15:45:17.000000000 +0200
> +++ sched.h     2003-05-13 18:07:01.000000000 +0200
> @@ -158,10 +158,8 @@
>  # define CONFIG_NR_SIBLINGS 0
>  #endif
> -#ifdef CONFIG_NR_SIBLINGS
> +#if CONFIG_NR_SIBLINGS
>  # define CONFIG_SHARE_RUNQUEUE 1
> -#else
> -# define CONFIG_SHARE_RUNQUEUE 0
>  #endif
>  extern void sched_map_runqueue(int cpu1, int cpu2);

Linus just committed a patch to eliminate such offenders.

Do you mean #if CONFIG_NR_SIBLINGS != 0 or #ifdef CONFIG_NR_SIBLINGS?


-- wli
