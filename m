Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933758AbWKQR7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758AbWKQR7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933755AbWKQR7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:59:43 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:28085 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S933758AbWKQR7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:59:42 -0500
Message-ID: <455DF7CF.7020203@gentoo.org>
Date: Fri, 17 Nov 2006 12:56:31 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: regarding VIA quirk fix
References: <455D8B44.2060600@gmail.com>
In-Reply-To: <455D8B44.2060600@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, Alan.
> 
> We've been getting bug reports from sata_via users for quite sometime 
> now.  The first IRQ driven command (IDENTIFY) times out and thus device 
> detection fails.  The following patch seems to fix it for many users.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116300291505638
> 
> But, not for all.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7415
> 
> Any ideas how to proceed on this bug?

I'm not certain, but I think that this is an unrelated issue. Both the 
working kernel and the failing kernels quirk the device in the same way:

PCI: VIA IRQ fixup for 0000:00:0f.0, from 11 to 2

Both the working kernel (2.6.17-gentoo-r8) and the first failing kernel 
(2.6.18-gentoo) have the same patch for 'fixing' the quirk issues: 
Chris's changes were reverted, the VIA IRQ quirk was back in the 2.6.16 
state. Since then the same issues have been observed with unpatched 
2.6.19-rc.

This is not definitive but suggests the issue is elsewhere.

Daniel
