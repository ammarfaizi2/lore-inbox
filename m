Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEZFHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEZFHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 01:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEZFHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 01:07:40 -0400
Received: from main.gmane.org ([80.91.229.2]:25569 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261205AbVEZFHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 01:07:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Date: Thu, 26 May 2005 07:06:29 +0200
Message-ID: <pide2disi8p3$.ap55vxesqd8k.dlg@40tude.net>
References: <4847F-8q-23@gated-at.bofh.it> <4295005F.nail2KW319F89@burner> <8E909B69-1F19-4520-B162-B811E288B647@mac.com> <200505260945.01886.patrakov@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-43-251.37-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005 09:45:01 +0600, Alexander E. Patrakov wrote:

> That list would be device-dependent. See two examples below.
> 
> 1) cdrecord uses some Sony proprietary commands instead of standard MMC ones 
> if the drive seems to be made by Sony. What is the effect of those Sony 
> commands on non-Sony drives?
> 
> 2) I have the following DVD-ROM + CD-RW combo drive:
> 
> 'PHILIPS ' 'CDD5301         ' 'P1.2'
> 
> Originally, I bought it with the 'B1.1' firmware revision. This drive with old 
> firmware is a security hole by itself: if one calls cdrecord dev=/dev/hdd 
> -dao some-image.iso, the drive will enter some strange mode at the end. In 
> particular, it will flash its light randomly, will never give the CD back 
> (waited 15 minutes), and will prevent communication with /dev/hdc until I 
> power off the computer (pressing Reset is not enough). Burning CDs with -raw 
> switch instead of -dao works. With newer firmware, -dao doesn't lock up the 
> drive, but still results in damaged CDs.
> 
> Also this drive always silently produces CDs with a lot of wrong bits (but a 
> useless and broken image can still be read with dd or readcd) when BurnFree 
> is off.
> 
> So this filter, if it is in the kernel, should forbid commands specific to SAO 
> burning for this drive _and_ also return a modified list of capabilities for 
> this drive (i.e. say that this drive _cannot_ burn in SAO mode).
> 
> Isn't this too much knowledge for the kernel?

Isn't this exactly the knowledge the kernel, not the apps, should
have? What if I wanted to use a different CD burning program? Why
should we have duplicate knowledge about the hardware?

Do you picture every PCI-accessing userland program to have its own
copy of pciids & relative knowledge?

-- 
Giuseppe "Oblomov" Bilotta

"I weep for our generation" -- Charlie Brown

