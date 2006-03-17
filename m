Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWCQR5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWCQR5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWCQR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:57:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17385 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030237AbWCQR5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:57:05 -0500
Subject: Re: [PATCH: 011/017]Memory hotplug for new nodes v.4.(start kswapd)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060317163538.C64D.Y-GOTO@jp.fujitsu.com>
References: <20060317163538.C64D.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 09:55:47 -0800
Message-Id: <1142618147.10906.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 17:22 +0900, Yasunori Goto wrote
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +/* start new kswapd for new node */
> +extern int kswapd_run(int nid);
> +#endif

I'd move this code down to where you actually use the extern.  I'd also
take the #ifdef out.  It won't hurt anything to have the extern there
all the time.

-- Dave

