Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUFWTmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUFWTmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUFWTmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:42:49 -0400
Received: from holomorphy.com ([207.189.100.168]:46212 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266627AbUFWTms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:42:48 -0400
Date: Wed, 23 Jun 2004 12:42:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More bug fix in mm/hugetlb.c - fix try_to_free_low()
Message-ID: <20040623194243.GB1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org
References: <200406231931.i5NJVeY10040@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406231931.i5NJVeY10040@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 12:33:00PM -0700, Chen, Kenneth W wrote:
> The argument "count" passed to try_to_free_low() is the config parameter
> for desired hugetlb page pool size.  But the implementation took that
> input argument as number of pages to free. It also decrement the config
> parameter as well.  All give random behavior depend on how many hugetlb
> pages are in normal/highmem zone.
> A two line fix in try_to_free_low() would be:

Thanks for cleaning this up; there hasn't been much apparent interest
here lately so I've not gotten much in the way of bugreports to work.

I suspect a general hardening effort should go on here. I'll go about
cleaning up other arches, too.


-- wli
