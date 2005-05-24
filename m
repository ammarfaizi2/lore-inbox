Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVEXMPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVEXMPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEXMPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:15:47 -0400
Received: from colin.muc.de ([193.149.48.1]:58628 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262013AbVEXMPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:15:44 -0400
Date: 24 May 2005 14:15:42 +0200
Date: Tue, 24 May 2005 14:15:42 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [patch 1/4] CPU Hotplug support for X86_64
Message-ID: <20050524121542.GA86182@muc.de>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <20050524081304.011927000@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524081304.011927000@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 01:11:14AM -0700, Ashok Raj wrote:
>   * RED-PEN audit/test this more. I bet there is more state messed up here.
>   */
> -static __cpuinit void disable_smp(void)
> +static __init void disable_smp(void)

Why all these cpuinit->init changes? I think they should stay __cpuinit

The other way round looks ok.

-Andi
