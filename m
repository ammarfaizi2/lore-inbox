Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272321AbTG3XGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTG3XFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:05:13 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:3575 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272329AbTG3XFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:05:02 -0400
Subject: Re: Spinlock performance on Athlon MP (2.4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Scott L. Burson" <gyro@zeta-soft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hw.support@amd.com
In-Reply-To: <16168.12542.850631.294911@kali.zeta-soft.com>
References: <16168.12542.850631.294911@kali.zeta-soft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059605940.10447.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 23:59:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 22:50, Scott L. Burson wrote:
> First, and probably the reason you haven't heard more complaints about the
> problem, its severity is evidently dependent on the size of main memory.  At
> 512MB it doesn't seem to be much of a problem (right, Mathieu?).  At 2.5GB,
> which is what I have, it can be quite serious.  For instance, if I start two
> `find' processes at the roots of different filesystems, the system can spend
> (according to `top') 95% - 98% of its time in the kernel.  It even gets
> worse than that, but `top' stops updating -- in fact, the system can seem
> completely frozen, but it does recover eventually.  Stopping or killing one
> of the `find' processes brings it back fairly quickly, though it can take a
> while to accomplish that.

Thats the well understood DMA bounce buffers problem. It should be
better in current 2.4 or with something like the Red Hat enterpise
kenrel or probably the -aa patches.

Its nothing to do with AMD although it can in part depend on what I/O
dvevices your system has how much data hits the bounce buffers

