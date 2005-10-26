Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVJZWBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVJZWBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVJZWBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 18:01:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16316 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964951AbVJZWBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 18:01:15 -0400
Subject: Re: "Badness in local_bh_enable" - a reasonable fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Steve Snyder <R00020C@freescale.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200510261720.11478.R00020C@freescale.com>
References: <200510261534.38291.R00020C@freescale.com>
	 <200510261601.19369.R00020C@freescale.com>
	 <1130358242.4483.127.camel@mindpipe>
	 <200510261720.11478.R00020C@freescale.com>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 18:00:06 -0400
Message-Id: <1130364007.4483.144.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 17:20 -0400, Steve Snyder wrote:
> On Wednesday 26 October 2005 16:24, Lee Revell wrote:
> > On Wed, 2005-10-26 at 16:01 -0400, Steve Snyder wrote:
> > > What, you mean the driver?  No, it is built from source against the
> > > installed & running Fedora Core 3 kernel version 2.6.12-1.1380_FC3. 
> > 
> > No, your kernel is tainted because you loaded some otehr proprietary
> > module.  Maybe nvidia?
> 
> Yes, I did have the nvidia binary kernel module loaded.  After removing
> it (not uninstalling; I just specified use of the X.org vesa driver
> instead and rebooted) I get the same behavior - including the Tainted
> notation.

Some other binary only module must have been loaded.  The "P" in the
Tainted line indicates that the kernel was tainted by loading a
proprietary module.

Maybe you didn't do MODULE_LICENSE("GPL") in your driver?

LLee

