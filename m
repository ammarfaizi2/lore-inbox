Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVCYB0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVCYB0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVCYBZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:25:42 -0500
Received: from mx1.mail.ru ([194.67.23.121]:39018 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261402AbVCYBTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:19:51 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm2
Date: Fri, 25 Mar 2005 04:19:36 +0300
User-Agent: KMail/1.7.1
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Stefano Rivoir <s.rivoir@gts.it>,
       linux-kernel@vger.kernel.org, airlied@gmail.com
References: <20050324044114.5aa5b166.akpm@osdl.org> <20050324120504.32ee0656.akpm@osdl.org> <42432132.4080105@ens-lyon.org>
In-Reply-To: <42432132.4080105@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200503250419.37011.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 23:21, Brice Goglin wrote:
> Andrew Morton a écrit :
> > Stefano Rivoir <s.rivoir@gts.it> wrote:
> >>>--- linux-mm/include/linux/agp_backend.h.old
> >>>+++ linux-mm/include/linux/agp_backend.h

> >>>+extern struct agp_bridge_data * (*agp_find_bridge)(struct pci_dev *);

> >>Right, that fixed it for me.
> >
> > There were contradictory patches in flight and I stuck the latest drm
> > tree into rc1-mm2 at the last minute, alas.  You should revert
> > agp-make-some-code-static.patch.
> >
> > But I assume that fixing the compile warnings does not fix the oopses
> > which Stefano and Brice are seeing?
>
> My patch does fix both the compile warnings and my oops on my Radeon
> laptop.

It also allows my machine to boot.

	Alexey

		...
	drm_agp_init+0x30/0x8e
	drm_fill_in_dev+0xe7/0x195
	drm_get_dev+0x4a/0xba
	kobject_get+0xf/0x13
	do_initcalls+0x54/0xb0
	init+0x0/0x100
	init+0x0/0x100
	kernel_thread_helper+0x0/0x0b
	kernel_thread_helper+0x5/0x0b
		...
<0>Kernel panic - not syncing: Attempted to kill init!
