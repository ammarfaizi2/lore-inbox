Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTKDJvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTKDJvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:51:01 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:42369 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264035AbTKDJu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:50:59 -0500
To: davidm@hpl.hp.com
Cc: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>, linux-kernel@vger.kernel.org
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
References: <20031102181224.GD2149@ma.emulex.com>
	<yq0wuahan3t.fsf@trained-monkey.org>
	<20031103125259.GC16690@ma.emulex.com>
	<yq0sml5a63s.fsf@wildopensource.com>
	<16294.53393.763572.291298@napali.hpl.hp.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 04 Nov 2003 04:44:36 -0500
In-Reply-To: <16294.53393.763572.291298@napali.hpl.hp.com>
Message-ID: <yq04qxklb7f.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

Jes> Hmmm, my brain has gotten ia64ified ;-) It's basically the normal
Jes> mappings of the kernel, ie. the kernel text/data/bss segments as
Jes> well as anything you do not get back as a dynamic mapping such as
Jes> ioremap/vmalloc/kmap.

David> I don't think it's safe to use virt_to_page() on static kernel
David> addresses (text, data, and bss).  For example, ia64 linux
David> nowadays uses a virtual mapping for the static kernel memory,
David> so it's not part of the identity-mapped segment.

Mmmm good point, I stand corrected. It doesn't really make sense to do
it anyway, but maybe it's worth underlining in the doc if it hasn't
been done so already.

Cheers,
Jes
