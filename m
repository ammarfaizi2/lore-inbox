Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267735AbUHRVIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267735AbUHRVIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUHRVIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:08:39 -0400
Received: from holomorphy.com ([207.189.100.168]:29113 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267748AbUHRVFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:05:06 -0400
Date: Wed, 18 Aug 2004 14:05:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040818210503.GG11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, pj@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818205338.GF11200@holomorphy.com> <20040818135638.4326ca02.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818135638.4326ca02.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 13:53:38 -0700 William Lee Irwin III wrote:
>> Once it's decided how many it really takes, I'll fix up sparc32 as-needed.

On Wed, Aug 18, 2004 at 01:56:38PM -0700, David S. Miller wrote:
> (sorry for the emply reply previously)
> It needs 6 unless we start passing in a 64-bit value to io_remap_page_range()
> for the 'offset' parameter.
> Physical I/O addresses are 36-bits or so on sparc32 systems, which is
> why we need to pass in "offset" and "space".

We should pass 64-bit values to remap_page_range() also, then. Or
perhaps passing pfn's to both suffices, as it all has to be page
aligned anyway.


-- wli
