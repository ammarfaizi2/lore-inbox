Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUHCCFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUHCCFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 22:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUHCCFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 22:05:20 -0400
Received: from holomorphy.com ([207.189.100.168]:10929 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264973AbUHCCFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 22:05:08 -0400
Date: Mon, 2 Aug 2004 19:04:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040803020459.GV2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk> <20040802130729.2dae8fd5.davem@redhat.com> <20040802210119.GS2334@holomorphy.com> <20040802161514.54f02f60.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802161514.54f02f60.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004 14:01:19 -0700 William Lee Irwin III wrote:
>> I've found unusual results in this area. e.g. it does appear to matter
>> for mapping->tree_lock for database workloads that heavily share a
>> given file and access it in parallel. The radix tree walk, though
>> intuitively short, is long enough to make the rwlock a win in the
>> database-oriented uses and microbenchmarks starting around 4x.

On Mon, Aug 02, 2004 at 04:15:14PM -0700, David S. Miller wrote:
> Thanks for the data point, because I had this patch I had sent
> to Rusty for 2.7.x which ripped rwlocks entirely out of the
> kernel.  We might have to toss that idea :-)

In all honesty, I'd rather use RCU, but that's a little more work than
most RCU conversions.


-- wli
