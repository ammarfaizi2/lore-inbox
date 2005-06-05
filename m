Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFELR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFELR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 07:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVFELR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 07:17:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:1755 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261320AbVFELR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 07:17:58 -0400
Date: Sun, 5 Jun 2005 13:17:56 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, nanhai.zou@intel.com,
       rohit.seth@intel.com, rajesh.shah@intel.com
Subject: Re: [discuss] Re: [Patch] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050605111755.GT23831@wotan.suse.de>
References: <20050602133256.A14384@unix-os.sc.intel.com> <20050602135013.4cba3ae2.akpm@osdl.org> <20050602151912.B14384@unix-os.sc.intel.com> <20050602154823.15141bfc.akpm@osdl.org> <20050602160603.C14384@unix-os.sc.intel.com> <20050603154839.GN23831@wotan.suse.de> <20050603120913.C29609@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603120913.C29609@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 12:09:14PM -0700, Siddha, Suresh B wrote:
> can happen in syscall32_setup_pages because of a malicious app and 
> another is the 32bit hugetlb application failure(which was also observed 
> by a customer recently). More details are in my changeset comments.

Ok agreed the memory leak needs to be fixed somehow.

The hugetlb thing should be caught by the compat mmap function. I will
double check it.
-andi
