Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVCJGTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVCJGTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCIT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:59:16 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:25086 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261213AbVCIThc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:37:32 -0500
Date: Wed, 9 Mar 2005 11:37:28 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
Message-ID: <20050309193728.GA7070@taniwha.stupidest.org>
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:53:48AM -0800, Dan Stromberg wrote:

> My question is, what is the current status of huge filesystems - IE,
> filesystems that exceed 2 terabytes, and hopefully also exceeding 16
> terabytes?

people can and do have >2T filesystems now.  some people on x86 have
hit the 16TB limit and others are large still with 64-bit CPUs

> Am I correct in assuming that the usual linux buffer cache only goes
> to 16 terabytes?

for 32-bit CPUs

> What about the "LBD" patches - what limits are involved there, and
> have they been rolled into a Linus kernel, or one or more vendor
> kernels?

LBD is in 2.6.x and is required for >2TB but sometimes that means >1TB
or even smaller depending on the drivers

many drivers simply won't go above 2T even with CONFIG_LBD so you need
to poke about and see what works for you (or use md/raid to glue
together multiple 2TB volumes)
