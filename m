Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268690AbTCCSJf>; Mon, 3 Mar 2003 13:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268688AbTCCSJJ>; Mon, 3 Mar 2003 13:09:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17820
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268690AbTCCSIh>; Mon, 3 Mar 2003 13:08:37 -0500
Subject: Re: Dmesg: Use a PAE enabled kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Walrond <andrew@walrond.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E6387AE.9080001@walrond.org>
References: <3E63736F.6090000@walrond.org> <26670000.1046707704@[10.10.2.4]>
	 <3E6381B9.4090708@walrond.org>
	 <1046713568.6530.32.camel@irongate.swansea.linux.org.uk>
	 <3E6387AE.9080001@walrond.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046719362.7316.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 19:22:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 16:49, Andrew Walrond wrote:
> That accounts for the missing Gb then. I think the warning needs to be 
> more like "WARNING WARNING (WILL ROBINSON)! 1GB of very expensive ram 
> won't be used unless you enable PAE!!!"

That would require we could detect rambus memory 8)

	printk("Warning %dGb of %sram won't be used.\n", lost>>10,
rambus()?"expensive ");

But yes more seriously it would be a lot more useful and more
meaningful to tell people how much ram is not being used

> Just how slow is PAE then ?

It varies, it can cost you 5-10%. The bigger hit is that most 
I/O devices can't reach that memory directly from PCI space
so you get bounce buffer costs and more paging/vm management
overhead.


