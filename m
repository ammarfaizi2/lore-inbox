Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTKQTsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTKQTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:48:52 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:52358 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261270AbTKQTsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:48:50 -0500
Date: Mon, 17 Nov 2003 20:48:45 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Tudor <tudor@tudorejo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox Acceleration Probably_Just_Cosmetic Bug
Message-ID: <20031117194845.GC18448@vana.vc.cvut.cz>
References: <3FB75569.6040408@tudorejo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB75569.6040408@tudorejo.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 09:46:01PM +1100, Tudor wrote:
> Hi there,
> 
> Stewart Smith told me that this is where I report strange Linux Kernel bugs.
> 
> I'm running make menuconfig on 2.6.0-test9
> I've come across a strange cosmetic bug under:
> Device Drivers->Graphics Support
> 
> If you select "Matrox Acceleration" either built in or as module there 
> are two options:
> - G100/G200/G400/G450/G500 support
> and
> - G100/G200/G400 support
> 
> If you select the first, the second disappears.
> If you select the second, the first stays.

It is feature, so you can "extend" your driver later when you decide. Both
config options points to the same sources. In the past there was option
"G100-G550 support" with "Secondary head on G450/G550". Unfortunately 
G450 and G550 users were connecting monitor to the secondary output,
and then complaining that they do not see anything on the monitor.
So now this option is implicitly enabled when you select first choice,
and disabled when you select second one.

Unless you cannot afford about 16KB for secondary CRTC driver, you should
select first choice, as it gives you better upgrade path.
							Petr Vandrovec

