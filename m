Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVD2Wh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVD2Wh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbVD2Wh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:37:28 -0400
Received: from main.gmane.org ([80.91.229.2]:22938 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263039AbVD2WhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:37:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Date: Fri, 29 Apr 2005 22:16:27 +0000 (UTC)
Message-ID: <loom.20050430T001503-359@post.gmane.org>
References: <1114493609.7183.55.camel@gaston> <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston> <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org> <20050427223702.21051afc.davem@davemloft.net> <1114670353.7182.246.camel@gaston> <20050427235056.0bd09a94.davem@davemloft.net> <20050428151117.GB10171@colo.lackof.org> <1114728447.7182.262.camel@gaston> <20050428233828.GI10171@colo.lackof.org> <20050429084242.38db3aeb.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 143.183.121.3 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.7) Gecko/20050414 Firefox/1.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem <at> davemloft.net> writes:
> The only problem could me getting the generic mmap() code to
> properly pass the flag down into the driver, I seem to recall
> that it either does an -EINVAL or masks out any flags which
> are not in the standard set.

But it would be a relatively clean solution, if a bit arch specific (i.e. some
arches would allow MAP_WRITECOMBINE or somesuch, while others have different
sorts of batching attributes).

> But then again this conflicts with what I remember seeing in the
> XFree86 PCI support, in that IA64 passed in such a mmap() flag
> to indicate a framebuffer like mapping that didn't need a guard-like
> bit to be set.

It used an ioctl last time I looked.

Jesse


