Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUB2HwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUB2HwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:52:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:47310 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262005AbUB2HwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:52:01 -0500
Message-ID: <40419A15.8030108@matchmail.com>
Date: Sat, 28 Feb 2004 23:51:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
CC: greg@kroah.com, jamagallon@able.es, PrakashKC@gmx.de, akpm@osdl.org
Subject: Re: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org>	<403E82D8.3030209@gmx.de>	<20040225185536.57b56716.akpm@osdl.org>	<20040227001115.GA2627@werewolf.able.es>	<20040227004602.GB15075@kroah.com>	<1077870909.403f013dd04b6@imp.gcu.info>	<403F898A.2000801@matchmail.com> <20040227205922.6405eff7.khali@linux-fr.org>
In-Reply-To: <20040227205922.6405eff7.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
>>You have to be kidding me.  Are you saying that with your patches to 
>>libsensors it won't support 2.6.3 style sensor sysfs names?
> 
> 
> Yes I am.  This isn't a fundamentally new problem.  Each Linux 2.6 has
> had its matching libsensors version that was not backward compatible
> (with earlier 2.6 kernels; it's still fully compatible with 2.4).
> 
> Keeping newer versions of libsensors compatible with all early 2.6
> kernel versions would make it incredibly more complex, with no
> significant benefit IMHO.
> 
> The facts are that the sysfs interface to i2c chips is just stabilizing.
> Greg's original naming scheme had many drawbacks (also we can't blame
> him for that, since nobody objected before me), as I have been
> explaining in a previous post on LKML. Also, many chip drivers did not
> comply with it in early 2.6 kernels, and new chip drivers wouldn't fit
> in it anyway.
> 
> The new interface is required if we want to write a chip-independant
> libsensors someday. I estimate that this is worth breaking the
> compatibility. The impacted kernels (later 2.5 and earlier 2.6) will
> obviously not be used anymore within a short time anyway.
> 
> I invite you to read my original post here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107715308608606
> 
> I explain the problems of the current interface and my goals with the
> new one. If you can think of a better solution to the problem, please
> speak up.

Working from the premise that there is a current (old-style with mostly 
chip dependent code), libsensors has 2.4 /proc support, and each 
specific release supports one of 2.6.[0123]...

I'm glad I'm not the maintainer of libsensors for a distribution.  Since 
you have effectively pushed the compatibility work to them.  Just think 
of angry customer complaints about this. :(

Since there is going to be an effective libsensors-new library with chip 
independent code, I suggest you put the compat code into the old library.

Mike
