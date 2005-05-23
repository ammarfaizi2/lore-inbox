Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVEWQiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVEWQiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 12:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVEWQiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 12:38:19 -0400
Received: from colin.muc.de ([193.149.48.1]:22279 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261903AbVEWQiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 12:38:18 -0400
Date: 23 May 2005 18:38:16 +0200
Date: Mon, 23 May 2005 18:38:16 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] CPU hot-plug support for x86_64
Message-ID: <20050523163816.GA39821@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050520223417.532048000@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520223417.532048000@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 03:16:24PM -0700, Ashok Raj wrote:
> Experimental CPU hotplug patch for x86_64
> -----------------------------------------
> - Most of init code that needs to be there for hotplug marked now as __devinit
> 	(Didn't use cpuinit, simply because the main framework code in kernel
> 	 is not the same way, just trying to be consistent)

I dont like that. Can you keep it as __cpuinit please?  e.g. 
if cpuhot plug turns out to be a lot of code we could later
mark it free when we detect at boot the system does not support
cpu hotplug. With devinit that is pretty much impossible these days.

Also it is better for documentation purposes.

Havent read the full patch yet sorry, but it seems to mostly 
consist of these changes anyways?


-Andi
