Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSGKXZs>; Thu, 11 Jul 2002 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSGKXZr>; Thu, 11 Jul 2002 19:25:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52192 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317946AbSGKXZq>;
	Thu, 11 Jul 2002 19:25:46 -0400
Date: Thu, 11 Jul 2002 13:07:38 -0500
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry Kessler <kessler@us.ibm.com>, Kurt Garloff <garloff@suse.de>,
       Perches Joe <joe.perches@spirentcom.com>, thunder@ngforever.de,
       bunk@fs.tum.de, boissiere@adiglobal.com, linux-kernel@vger.kernel.org,
       "'Martin.Bligh@us.ibm.com'" <Martin.Bligh@us.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020711180738.GB6002@krispykreme>
References: <3D2C88B2.FF9ECD5C@us.ibm.com> <E17SOoL-0007q9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SOoL-0007q9-00@the-village.bc.nu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> You need a bit more than that. You need a consistent way to report
> an IRQ number, a device name, a PCI object etc. That does mean tidying up
> printk but not in a bad way. One can imagine either
> 
> 	"%s", irq_name(irq)
> 
> or
> 	"%I", irq
> 
> type solutions

This would be nice. Ive been meaning to clean up the sparc64 irq
printing macros so I can use them on ppc64 (we have sparse irqs and
map them dynamically into the irq_desc array).

Same problem once we get PCI domains. So this cleanup will help more
than just event logging.

Anton
