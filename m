Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVJ0HvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVJ0HvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVJ0HvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:51:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:49560 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964981AbVJ0HvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:51:22 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Date: Thu, 27 Oct 2005 09:50:12 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
References: <20051026070956.GA3561@localhost.localdomain> <aec7e5c30510261840xf0d5bfapaf2f62959cb9a462@mail.gmail.com> <aec7e5c30510262325r7bf17bf3ved230fe79156e6ad@mail.gmail.com>
In-Reply-To: <aec7e5c30510262325r7bf17bf3ved230fe79156e6ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510270950.13268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 October 2005 08:25, Magnus Damm wrote:

> > While at it, could you please consider to remove the SMP dependency
> > from NUMA_EMU? 2.6.14-rc5-git5 builds and works with !SMP and

No.

> > NUMA_EMU.
> >
> > Why?
> > 1. No need to force SMP when not needed.
> > 2. qemu-system-x86_64 does not currently work with SMP kernels.

qemu needs to be fixed then.

> Update:
>
> Both CONFIG_NUMA_EMU and CONFIG_K8_NUMA build and run just fine
> without CONFIG_SMP. Not sure about CONFIG_ACPI_NUMA though.

I don't want too many weird combinations which no normal person uses like 
this. Undoubtedly there will be compile breakage for such stuff in the future 
(even if it happens to work by chance now) and best is to not open this can 
of worms in the first place. The number of variants has to be kept under 
control.

-And

