Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263709AbSITU7g>; Fri, 20 Sep 2002 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263632AbSITU6I>; Fri, 20 Sep 2002 16:58:08 -0400
Received: from holomorphy.com ([66.224.33.161]:6026 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263634AbSITU6B>;
	Fri, 20 Sep 2002 16:58:01 -0400
Date: Fri, 20 Sep 2002 13:56:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Bond, Andrew" <Andrew.Bond@hp.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
Message-ID: <20020920205653.GM3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Bond, Andrew" <Andrew.Bond@hp.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
References: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 02:27:22PM -0500, Bond, Andrew wrote:
> This isn't as recent as I would like, but it will give you an idea.
> Top 75 from readprofile.  This run was not using bigpages though.
> Andy

> 00000000 total                                      7872   0.0066
> c0105400 default_idle                               1367  21.3594
> c012ea20 find_vma_prev                               462   2.2212
> c0142840 create_bounce                               378   1.1250
> c0142540 bounce_end_io_read                          332   0.9881
> c0197740 __make_request                              256   0.1290
> c012af20 zap_page_range                              231   0.1739
> c012e9a0 find_vma                                    214   1.6719
> c012e780 avl_rebalance                               160   0.4762

Looks like you're doing a lot of mmapping or faulting requiring VMA
lookups, or the number of VMA's associated with a task makes the
various VMA manipulations extremely expensive.

Can you dump /proc/pid/maps on some of these processes?

Thanks,
Bill
