Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268109AbUHKQ6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268109AbUHKQ6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUHKQ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:58:31 -0400
Received: from holomorphy.com ([207.189.100.168]:42628 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268092AbUHKQ62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:58:28 -0400
Date: Wed, 11 Aug 2004 09:54:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040811165459.GR11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, davem@redhat.com,
	geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
References: <20040807170122.GM17708@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807170122.GM17708@fs.tum.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 07:01:22PM +0200, Adrian Bunk wrote:
> The following architetures have their own "config PCMCIA" instead of 
> including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
> - m68k
> - s390
> - sparc
> - sparc64
> Is there any good reason for this, or would a patch to change these 
> architectures to include drivers/pcmcia/Kconfig be OK?

I'd like to switch things over to drivers/Kconfig and/or
drivers/pcmcia/Kconfig. If the drivers are bust I'll just sweep them
when someone complains about the build being bust. One could
proactively find these with make allmodconfig and/or allyesconfig, but
I suspect that may be too large a set of drivers to digest all at once.
Or maybe not -- akpm does scale, after all.


-- wli
