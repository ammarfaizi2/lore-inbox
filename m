Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVA3LXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVA3LXR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVA3LWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:22:39 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:28722 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261679AbVA3LW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:22:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QLsUv/HRm30HHLuL+2mjX5eIH5ySvoS8ED/DgldNtnIU0+/jkUA1GvqVWaJ3lweQCU2YogNQEUsuKWBnm4Ex7h1IRl7Ki8cBvouYpB7ujgfYZhcGtIPRvbOTLvqnGBPiGlNyVq1QQmL3J19PXmT1B12+9KnpMOfQgkAQ8I1kzm8=
Message-ID: <21d7e9970501300322ffdabe0@mail.gmail.com>
Date: Sun, 30 Jan 2005 22:22:24 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20050130111634.GA9269@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> After sorting out a stupid build problem, here is the result for
> the binary search for the crash.
> 2.6.9         crash
> 2.6.9-rc2     pci-oom
> 2.6.9-rc3     crash
> 2.6.9-rc2-bk7 crash
> 2.6.9-rc2-bk4 crash
> 2.6.9-rc2-bk2 pci-oom
> 2.6.9-rc2-bk3 krash in ifconfig
> 
> Up to 2.6.9-rc2-bk2 we don't get a crash, instead the X log shows this:
> 
> (EE) RADEON(0): [pci] Out of memory (-1007)
> 
> and gives up on drm in an orderly fashion.
> 2.6.9-rc2-bk4 crashes though.  As usual, the X log ends with:
> (II) LoadModule: "int10"
> (II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
> (II) RADEON(0): initializing int10
> (**) RADEON(0): Option "InitPrimary" "on"
> (II) Truncating PCI BIOS Length to 53248
> 
> 2.6.9-rc2-bk3 wasn't tested further, because the kernel dies upon
> running "ifconfig" which must be some other temporary bug.
> X will probably be difficult without IPv4 anyway.
> 

Just another guess, but Jon could the PCI ROM patch mess up X's access
via the Int10 handler .. maybe if it isn't mapped properly..?

Dave.
