Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWCORk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWCORk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 12:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWCORk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 12:40:57 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:27563 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750780AbWCORk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 12:40:57 -0500
To: hawkes@sgi.com
Cc: Kenneth Chen <kenneth.w.chen@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] fix alloc_large_system_hash roundup
X-Message-Flag: Warning: May contain useful information
References: <20060315173639.11102.71657.sendpatchset@tomahawk.engr.sgi.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 09:40:52 -0800
In-Reply-To: <20060315173639.11102.71657.sendpatchset@tomahawk.engr.sgi.com> (hawkes@sgi.com's message of "Wed, 15 Mar 2006 09:36:39 -0800")
Message-ID: <adazmjr38t7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Mar 2006 17:40:53.0691 (UTC) FILETIME=[9B9F70B0:01C64857]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >  	/* rounded up to nearest power of 2 in size */
 > -	numentries = 1UL << (long_log2(numentries) + 1);
 > +	numentries = 1UL << (long_log2(2*numentries - 1));

How about just using roundup_pow_of_two()?  You could kill the comment
too then.

 - R.
