Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSLDSXT>; Wed, 4 Dec 2002 13:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbSLDSXT>; Wed, 4 Dec 2002 13:23:19 -0500
Received: from holomorphy.com ([66.224.33.161]:37765 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267010AbSLDSXS>;
	Wed, 4 Dec 2002 13:23:18 -0500
Date: Wed, 4 Dec 2002 10:30:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: per cpu time statistics
Message-ID: <20021204183043.GJ808@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Erich Focht <efocht@ess.nec.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	LSE <lse-tech@lists.sourceforge.net>
References: <200212041343.39734.efocht@ess.nec.de> <3DEE3FAE.558649F5@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEE3FAE.558649F5@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
>> I had to learn from Michael Hohnbaum that you've eliminated the per
>> CPU time statistics in 2.5.50 (akpm changeset from Nov. 26). Reading
>> the cset comments I understood that the motivation was to save
>> 8*NR_CPUS bytes of memory in the task_struct. Maybe that was really an
>> issue at the time when Bill suggested the patch (July), but in the
>> mean time we got configurable NR_CPUS (October) and that small amount
>> of additional memory really doesn't matter. Most people running SMP
>> have 2 CPUs.

On Wed, Dec 04, 2002 at 09:47:26AM -0800, Andrew Morton wrote:
> It's mainly the big ia32 boxes which a) have a lot of CPUs and
> b) have a lot of memory and c) run a lot of tasks.  They're
> gasping for normal-zone memory.
> I'm half-inclined to just revert the whole thing and put the stats
> back, rather than adding yet another obscure config option.  But
> your patch is certainly very tidy...


I'm (obviously) in favor of Erich's patch. =)

Still gasping for ZONE_NORMAL,
Bill
