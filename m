Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUHYPwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUHYPwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHYPwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:52:31 -0400
Received: from palrel13.hp.com ([156.153.255.238]:44433 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S268057AbUHYPwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:52:24 -0400
Date: Wed, 25 Aug 2004 08:52:13 -0700
From: Grant Grundler <iod00d@hp.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
Message-ID: <20040825155213.GB19447@cup.hp.com>
References: <412AD123.8050605@jp.fujitsu.com> <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org> <1093417267.2170.47.camel@gaston> <Pine.LNX.4.58.0408250015420.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408250015420.17766@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:20:45AM -0700, Linus Torvalds wrote:
> Because if you don't lock the bridge (or whatever the entity is that keeps 
> track of errors), the whole exercise is kind of pointless. If two drivers 
> try to do error checking at the same time, and will potentially clear the 
> errors of each other, causing the errors to get lost, the whole recovery 
> infrastructure is clearly worthless.

Do we only need to determine there was an error in the IO hierarchy
or do we also need to know which device/driver caused the error?

If the latter I agree with linus. If the former, then the error recovery
can support asyncronous errors (like the bad DMA address case) and tell
all affected (thanks willy) drivers.

grant
