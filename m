Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWBYIyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWBYIyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWBYIyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:54:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932622AbWBYIyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:54:11 -0500
Date: Sat, 25 Feb 2006 08:54:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>
Subject: Re: [PATCH] Enable mprotect on huge pages
Message-ID: <20060225085409.GA22456@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
	"yanmin.zhang@intel.com" <yanmin.zhang@intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 11:19:40AM +0800, Zhang, Yanmin wrote:
> From: Zhang, Yanmin <yanmin.zhang@intel.com>
> 
> 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn?t support hugetlb
> mprotect. My patch against 2.6.16-rc3 enables this capability.

Adding another special case for hugetlb pages sounds rather bad.  Could
you try adding a mrotect vm_area_operation if that works out cleaner?

