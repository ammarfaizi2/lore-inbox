Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUJOBfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUJOBfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUJOBfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:35:44 -0400
Received: from ozlabs.org ([203.10.76.45]:17885 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267994AbUJOBfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:35:11 -0400
Subject: Re: [PATCH 1/5][Diskdump] IPF(IA64) support
From: Rusty Russell <rusty@rustcorp.com.au>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <15C4709AD81CB1indou.takao@soft.fujitsu.com>
References: <14C4709A99D341indou.takao@soft.fujitsu.com>
	 <15C4709AD81CB1indou.takao@soft.fujitsu.com>
Content-Type: text/plain
Message-Id: <1097804121.22673.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:35:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 19:53, Takao Indoh wrote:
> +static unsigned int fallback_on_err = 1;
> +static unsigned int allow_risky_dumps = 1;
> +static unsigned int block_order = 2;
> +static int sample_rate = 8;
> +module_param(fallback_on_err, uint, 0);
> +module_param(allow_risky_dumps, uint, 0);
> +module_param(block_order, uint, 0);
> +module_param(sample_rate, int, 0);

Hi Takao!

	Are you sure you want "uint" for fallback_on_err and allow_risky_dumps
and not "bool"?  Also, I suggest "0400" as permissions so you can read
them out of sysfs; maybe even 0600 if these parameters can be changed
after loading.

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

