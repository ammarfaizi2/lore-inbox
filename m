Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUIQFyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUIQFyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIQFye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:54:34 -0400
Received: from fmr12.intel.com ([134.134.136.15]:56806 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268206AbUIQFyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:54:33 -0400
Subject: Re: hotplug e1000 failed after 32 times
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040916221406.1f3764e0.akpm@osdl.org>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
	 <20040916221406.1f3764e0.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1095400095.10407.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 13:48:15 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 13:14, Andrew Morton wrote:
> Li Shaohua <shaohua.li@intel.com> wrote:
> >
> > I'm testing a hotplug driver. In my test, I will hot add/remove an e1000
> >  NIC frequently. The result is my hot add failed after 32 times hotadd.
> >  After looking at the code of e1000 driver, I found
> >  e1000_adapter->bd_number has maxium limitation of 32, and it increased
> >  one every hot add. Looks like the remove driver routine didn't free the
> >  'bd_number', so hot add failed after 32 times. Below patch fixes this
> >  issue.
> 
> Yeah.  I think you'll find that damn near every net driver in the kernel
> has this problem.  I think it would be better to create a little suite of
> library functions in net/core/dev.c to handle this situation.
Thanks Andrew. That makes sense. I will add as you said.

Thanks,
Shaohua

