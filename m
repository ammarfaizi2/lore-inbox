Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUB0T7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUB0T7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:59:12 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:38669 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263003AbUB0T7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:59:10 -0500
Date: Fri, 27 Feb 2004 20:59:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: greg@kroah.com, jamagallon@able.es, PrakashKC@gmx.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       sensors@Stimpy.netroedge.com
Subject: Re: 2.6.3-mm4
Message-Id: <20040227205922.6405eff7.khali@linux-fr.org>
In-Reply-To: <403F898A.2000801@matchmail.com>
References: <20040225185536.57b56716.akpm@osdl.org>
	<403E82D8.3030209@gmx.de>
	<20040225185536.57b56716.akpm@osdl.org>
	<20040227001115.GA2627@werewolf.able.es>
	<20040227004602.GB15075@kroah.com>
	<1077870909.403f013dd04b6@imp.gcu.info>
	<403F898A.2000801@matchmail.com>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have to be kidding me.  Are you saying that with your patches to 
> libsensors it won't support 2.6.3 style sensor sysfs names?

Yes I am.  This isn't a fundamentally new problem.  Each Linux 2.6 has
had its matching libsensors version that was not backward compatible
(with earlier 2.6 kernels; it's still fully compatible with 2.4).

Keeping newer versions of libsensors compatible with all early 2.6
kernel versions would make it incredibly more complex, with no
significant benefit IMHO.

The facts are that the sysfs interface to i2c chips is just stabilizing.
Greg's original naming scheme had many drawbacks (also we can't blame
him for that, since nobody objected before me), as I have been
explaining in a previous post on LKML. Also, many chip drivers did not
comply with it in early 2.6 kernels, and new chip drivers wouldn't fit
in it anyway.

The new interface is required if we want to write a chip-independant
libsensors someday. I estimate that this is worth breaking the
compatibility. The impacted kernels (later 2.5 and earlier 2.6) will
obviously not be used anymore within a short time anyway.

I invite you to read my original post here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107715308608606

I explain the problems of the current interface and my goals with the
new one. If you can think of a better solution to the problem, please
speak up.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
