Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUINX23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUINX23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUINX22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:28:28 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:9403 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S265044AbUINX10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:27:26 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
Date: Tue, 14 Sep 2004 17:27:15 -0600
User-Agent: KMail/1.6.2
Cc: dri-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Evan Paul Fletcher <evanpaul@gmail.com>, linux-kernel@vger.kernel.org
References: <200409131651.05059.bjorn.helgaas@hp.com> <200409140845.59389.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0409150008130.23838@skynet>
In-Reply-To: <Pine.LNX.4.58.0409150008130.23838@skynet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141727.15643.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 5:12 pm, Dave Airlie wrote:
> > OK, I'll assume you understand the issue and will resolve it.  In the
> > meantime, users of DRM will have to supply "pci=routeirq".
> 
> is this -mm only or is it mainline kernel stuff now?

It's been in -mm for about a month so far, and it still
needs some cooking before it's ready for mainline.  The
remaining issues are:

	- nvidia: Nvidia posted a patch for the open-source part
		of their driver, but we'll likely have to keep
		the "pci=routeirq" option longer than I originally
		hoped.
	- swsusp: Some devices like prism54, USB don't
		work after suspend/resume.  Prototype patch
		being tested.  I suspect we'll trip over
		more issues here, because the resume hooks
		are poorly documented and inconsistently
		implemented.
	- DRI: Sounds like you can do the trivial "enable-only"
		change that will make things work.

I'm a little surprised that I've only heard one report about
DRI, actually.

> I'll throw an enable in to the bk tree later on....

Great, thanks!
