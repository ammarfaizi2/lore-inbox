Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTJ1Wma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJ1Wma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:42:30 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:34577 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261764AbTJ1Wm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:42:28 -0500
Message-ID: <3F9EF0C9.3090507@enterprise.bidmc.harvard.edu>
Date: Tue, 28 Oct 2003 17:42:17 -0500
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
References: <Pine.LNX.4.44.0310281349210.4639-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310281349210.4639-100000@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>Joachim, 
>The patch in question has caused other problems and will be removed.
>  
>

Speaking of patches causing problems and needing reversion, can the 
screen-corrupting RadeonFB patch introduced in 2.4.23-pre3 be reverted 
until such time as it is fixed?  I know there was a maintainer war going 
on over who should officially submit RadeonFB patches; somewhere in 
there, updates and fixes stopped coming.

As it now stands in current -pre kernels, returning from XFree86 to a 
RadeonFB console results in total gibberish all over the screen (with my 
hardware anyway, a standard Built-by-ATI Radeon 8500 LE chipset QL 
rev0).  There is no workaround, other than to return to X.  Another bug 
also causes screen corruption when switching VCs (it forgets where in 
the YPan it is), but this can be easily worked around by setting VYRES = 
YRES (fbset -match -a).

The previous version of RadeonFB in 2.4.23-pre2 and earlier works just 
fine on my Radeon 8500 hardware, albeit without accelerated scrolling.  
Of course, if people with other Radeon flavors can't use the older 
driver but the newer one works for them, then short of a 
CONFIG_OLD_RADEONFB, I guess we should keep the current one...

Kris


