Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269484AbUI3WVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269484AbUI3WVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269558AbUI3WVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:21:32 -0400
Received: from fmr04.intel.com ([143.183.121.6]:12725 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269484AbUI3WVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:21:30 -0400
Date: Thu, 30 Sep 2004 15:21:17 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, greg@kroah.com,
       ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add hook for PCI resource deallocation
Message-ID: <20040930152117.A30196@unix-os.sc.intel.com>
References: <41498CF6.9000808@jp.fujitsu.com> <20040924130251.A26271@unix-os.sc.intel.com> <20040924212208.GD7619@kroah.com> <4157CA04.5050604@jp.fujitsu.com> <20040930145014.71e04b25.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040930145014.71e04b25.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 30, 2004 at 02:50:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 02:50:14PM -0700, Andrew Morton wrote:
> Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> >
> > I'm attaching updated patches for adding pcibiod_disable_device()
> > hook based on the feedback from Ashok (Thank you, Ashok!).
> 
> This appears to be a patch-reversed version of the patch which is already
> in -mm:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/broken-out/add-hook-for-pci-resource-deallocation.patch
> 
> So I'm not sure what you're trying to do here.


In the original patch, Kenji added a dummy function in several source files. Instead now
the new patch should have a single default implementation with a __attribute__((weak))

As a result its removing all the old additions and now keeping just a single default function.

so yes, its a reverse patch mostly, but there should also be a new function added with the weak 
attribute.
-- 
Cheers,
Ashok Raj
- Linux OS & Technology Team
