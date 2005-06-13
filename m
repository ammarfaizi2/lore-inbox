Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFMBGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFMBGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFMBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:06:09 -0400
Received: from fmr19.intel.com ([134.134.136.18]:52941 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261304AbVFMBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:06:03 -0400
Subject: Re: [PATCH]x86-x86_64 flush cache for CPU hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: ak <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050610172149.GP1683@muc.de>
References: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
	 <20050610172149.GP1683@muc.de>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 09:13:46 +0800
Message-Id: <1118625227.3822.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 19:21 +0200, Andi Kleen wrote:
> On Fri, Jun 10, 2005 at 11:30:08AM +0800, Shaohua Li wrote:
> > Hi,
> > We should flush cache at CPU hotplug. An error has been observed data is
> > corrupted after CPU hotplug in CPUs with bigger cache.
> 
> Did you see that with actual hardware CPU hotplug? With software
> for testing only hotplug it should not make any difference.
Sure, this should only occur on physical CPU hotplug. I haven't hardware
which supports physical CPU hotplug. What I'm testing is supend-to-ram.
In this case, we offline all APs and BIOS possibly will put APs into
some special states (maybe reboot APs). It's very like physical CPU
hotplug.


> If you have a targetted test that causes the corruption that would be great
> so we can add to our stress test senarios.
No, I haven't. IA64 doesn't support suspend/resume, so my test case
can't apply to IA64.

Thanks,
Shaohua

