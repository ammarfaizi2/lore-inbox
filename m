Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWCGXgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWCGXgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWCGXgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:36:20 -0500
Received: from hera.kernel.org ([140.211.167.34]:7392 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751462AbWCGXgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:36:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Tue, 7 Mar 2006 15:36:00 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dul5d0$16r$1@terminus.zytor.com>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <m17j7kda52.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0602240925170.3771@g5.osdl.org> <43FF48F2.70508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1141774560 1244 127.0.0.1 (7 Mar 2006 23:36:00 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 7 Mar 2006 23:36:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <43FF48F2.70508@keyaccess.nl>
By author:    Rene Herman <rene.herman@keyaccess.nl>
In newsgroup: linux.dev.kernel
>
> Linus Torvalds wrote:
> 
> > The real issue is the _physical_ address. Nothing else matters.
> > 
> > If the TLB splitting on the fixed MTRRs is an issue, it depends entirely 
> > on what physical address the kernel resides in, and the virtual address is 
> > totally inconsequential.
> > 
> > So playing games with virtual mapping has absolutely no upsides, and it 
> > definitely has downsides.
> 
> The notion was that having a fixed virtual mapping of the kernel would 
> allow it to be loaded anywhere physically without needing to do actual 
> address fixups. The bootloader could then for example at runtime decide 
> to load the kernel at 16MB if the machine had enough memory available, 
> to free up ZONE_DMA. Or not do that if running on a <= 16MB machine.
> 

The only machines on which ZONE_DMA matters (machines with ISA DMA
devices) are also the ones which are likely to be <= 16 MB.

Yes, there are floppies, but I think having over 3 MB available for
floppy DMA is plenty, and floppies are FINALLY going away...

	-hpa
