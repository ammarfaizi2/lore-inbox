Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTKCOSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTKCOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:18:05 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:60133 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S261931AbTKCOSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:18:03 -0500
To: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
References: <20031102181224.GD2149@ma.emulex.com>
	<yq0wuahan3t.fsf@trained-monkey.org>
	<20031103125259.GC16690@ma.emulex.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Nov 2003 09:17:59 -0500
In-Reply-To: <20031103125259.GC16690@ma.emulex.com>
Message-ID: <yq0sml5a63s.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Wellnitz <Jamie.Wellnitz@emulex.com> writes:

Jamie> On Mon, Nov 03, 2003 at 03:10:46AM -0500, Jes Sorensen wrote:
>>  virt_to_page() can handle any page in the standard kernel region

Jamie> What is the "standard kernel region"?  ZONE_NORMAL?

Hmmm, my brain has gotten ia64ified ;-) It's basically the normal
mappings of the kernel, ie. the kernel text/data/bss segments as well
as anything you do not get back as a dynamic mapping such as
ioremap/vmalloc/kmap.

>> pci_map_page() is the correct API to use, pci_map_single() is
>> deprecated.

Jamie> Are you talking about 2.4 or 2.6 or both?

Both really.

Jamie> The Document/DMA-mapping.txt in 2.6.0-test9 says "To map a
Jamie> single region, you do:" and then shows pci_map_single.  Is
Jamie> DMA-mapping.txt in need of patching?

Sounds like it needs an update.

Cheers,
Jes
