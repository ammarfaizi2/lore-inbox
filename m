Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVDULue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVDULue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVDULue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:50:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:43679 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261302AbVDULua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:50:30 -0400
Date: Thu, 21 Apr 2005 13:50:30 +0200
From: Andi Kleen <ak@suse.de>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] [Patch] X86_64 TASK_SIZE cleanup
Message-ID: <20050421115030.GS7715@wotan.suse.de>
References: <894E37DECA393E4D9374E0ACBBE74270013E8B90@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894E37DECA393E4D9374E0ACBBE74270013E8B90@pdsmsx402.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 01:17:40AM +0800, Zou, Nanhai wrote:
> Hi Andi,
>    What is your comment on this patch?

There is at least one wrong change in there, you have a check
for test_thread_flag(TIF_IA32) && (flags & MAP_32BIT)

and that is wrong because MAP_32BIT is used from 64bit code

-Andi
