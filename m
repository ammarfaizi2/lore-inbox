Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVBPB7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVBPB7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVBPB7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:59:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10144 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261970AbVBPB71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:59:27 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Tue, 15 Feb 2005 17:57:58 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <1108515632.13394.59.camel@gaston> <9e473391050215170874051b29@mail.gmail.com>
In-Reply-To: <9e473391050215170874051b29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151757.58731.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 15, 2005 5:08 pm, Jon Smirl wrote:
> There is a new io resource flag as part of the pci rom code,
> IORESOURCE_ROM_SHADOW, that is used on x86. If IORESOURCE_ROM_SHADOW
> is set, you should ignore the physical ROM and use the copy at C000:0.
> Can we build an equivalent flag for PPC? On x86 arch specific code
> determines the boot video device and sets the flag.
>
> Acutally, if radeon and rage fb drivers were using the PCI ROM support
> (drivers/pci/rom.c) would they be having this problem? The 55AA check
> is in the PCI ROM support too.

They're using it, they just do additional checks.

Jesse
