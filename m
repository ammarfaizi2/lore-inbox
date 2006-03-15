Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWCOTGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWCOTGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 14:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWCOTGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 14:06:40 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:38162 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750872AbWCOTGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 14:06:39 -0500
X-IronPort-AV: i="4.02,195,1139212800"; 
   d="scan'208"; a="415928155:sNHT6609845956"
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: <hawkes@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Jack Steiner" <steiner@sgi.com>,
       "Jes Sorensen" <jes@sgi.com>
Subject: Re: [PATCH] fix alloc_large_system_hash roundup
X-Message-Flag: Warning: May contain useful information
References: <200603151828.k2FISxg19755@unix-os.sc.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 10:41:58 -0800
In-Reply-To: <200603151828.k2FISxg19755@unix-os.sc.intel.com> (Kenneth W. Chen's message of "Wed, 15 Mar 2006 10:29:00 -0800")
Message-ID: <adalkvb35zd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Mar 2006 18:41:59.0583 (UTC) FILETIME=[24AA2AF0:01C64860]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Kenneth> roundup_pow_of_two uses fls, but fls takes an "int"
    Kenneth> argument.  I think that function is buggy on 64-bit
    Kenneth> arch. Is it an oversight or something?

Huh, looks like you're right.  I never looked inside fls() before.
Yes, roundup_pow_of_two() should probably be fixed, since a naive
person (like me) would look at it and think it works on longs.

 - R.
