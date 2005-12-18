Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVLRQIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVLRQIB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVLRQIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:08:01 -0500
Received: from mxsf14.cluster1.charter.net ([209.225.28.214]:36530 "EHLO
	mxsf14.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965212AbVLRQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:08:00 -0500
X-IronPort-AV: i="3.99,266,1131339600"; 
   d="scan'208"; a="553663743:sNHT24650332"
Message-ID: <43A588C5.4020907@cybsft.com>
Date: Sun, 18 Dec 2005 10:05:25 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.15-rc5-rt2 slowness
References: <dnu8ku$ie4$1@sea.gmane.org>	 <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain>
In-Reply-To: <1134860251.13138.193.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Ingo,
> 
> I ported your old changes of 2.6.14-rt22 of mm/slab.c to 2.6.15-rc5-rt2
> and tried it out.  I believe that this confirms that the SLOB _is_ the
> problem in the slowness.  Booting with this slab patch, gives the old
> speeds that we use to have.
> 
> Now, is the solution to bring the SLOB up to par with the SLAB, or to
> make the SLAB as close to possible to the mainline (why remove NUMA?)
> and keep it for PREEMPT_RT?
> 
> Below is the port of the slab changes if anyone else would like to see
> if this speeds things up for them.
> 
> -- Steve
> 

This drastically improves performance on my slower uniprocessor system.
2.6.15-rc5-rt2 still doesn't boot on my dual 933 box, with or without
this patch. I will try to dig into that a bit more today.

-- 
   kr
