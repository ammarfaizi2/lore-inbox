Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVBQXIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVBQXIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVBQXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:07:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:32425 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261208AbVBQXF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:05:29 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105021714593115dacf@mail.gmail.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <200502170929.54100.jbarnes@sgi.com>
	 <9e47339105021709321dc72ab2@mail.gmail.com>
	 <200502170945.30536.jbarnes@sgi.com> <1108680436.5665.9.camel@gaston>
	 <9e47339105021714593115dacf@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 10:04:10 +1100
Message-Id: <1108681450.5666.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 17:59 -0500, Jon Smirl wrote:
> On Fri, 18 Feb 2005 09:47:15 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > We could provide additional helpers, like pci_find_rom_partition(),
> > which takes the architecture code as an argument. It would check the
> > signature, and iterate all "partitions" til it finds the proper
> > architecture (or none).
> 
> The spec allows for it but has anyone actually seen a ROM with
> multiple images in it? I haven't but I only work on x86.

Yes, I pretty sure some video cards did that in the past at least, and
maybe some scsi cards. It was a while ago, I don't know if this is still
true, but it's relatively easy to do, let's just hide all of this logic,
along with size & signature checking in a single place, that way, we
don't have to duplicate all that logic in drivers...

Ben.


