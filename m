Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWBWTbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWBWTbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWBWTbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:31:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:3738 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751108AbWBWTbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:31:08 -0500
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <43FE0B9A.40209@keyaccess.nl>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <1140707358.4672.67.camel@laptopd505.fenrus.org>
	 <200602231700.36333.ak@suse.de>
	 <1140713001.4672.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
	 <43FE0B9A.40209@keyaccess.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 19:34:49 +0000
Message-Id: <1140723289.4952.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-23 at 20:23 +0100, Rene Herman wrote:
> Linus Torvalds wrote:
> 
> > The same should be true on x86, btw. Where we should use a physical start 
> > address of 4MB for best performance.
> 
> Does 16MB still work? Gets the kernel out of the old ZONE_DMA. I suppose 
> not many people are really using that anyway anymore these days, but if 
> no downsides maybe?

Certainly the PAE kernel might as well do that and the AMD64 if it
doesn't already. There are complications however getting above 16MB
because 16bit protected mode (and maybe the BIOS helpers - I need to
check that) can't hit it.

We also used to have people DMAing into static kernel buffers in older
days but hopefully that habit is now dead and gone because modules
sorted most of it out.


