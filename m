Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161362AbWG1XMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161362AbWG1XMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWG1XMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:12:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27567
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161362AbWG1XMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:12:19 -0400
Date: Fri, 28 Jul 2006 16:12:15 -0700 (PDT)
Message-Id: <20060728.161215.98863664.davem@davemloft.net>
To: Valdis.Kletnieks@vt.edu
Cc: arjan@linux.intel.com, ak@suse.de, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607282305.k6SN5e0k015125@turing-police.cc.vt.edu>
References: <200607282045.05292.ak@suse.de>
	<1154112511.6416.46.camel@laptopd505.fenrus.org>
	<200607282305.k6SN5e0k015125@turing-police.cc.vt.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis.Kletnieks@vt.edu
Date: Fri, 28 Jul 2006 19:05:40 -0400

> On Fri, 28 Jul 2006 20:48:31 +0200, Arjan van de Ven said:
> > On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > > > +ifdef CONFIG_CC_STACKPROTECTOR
> > > > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > > > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> > > 
> > > Why can't you just use the normal call cc-option for this?
> > 
> > this requires gcc 4.2; cc-option is not useful for that.
> 
> At least some things calling themselves 4.1.1 include it.  On a Fedora

Your gcc-4.1.1 includes the -fstack-protector feature, but it might
not have the gcc bug fix necessary to make that feature work on the
kernel compile, which is why the version check is necessary.
