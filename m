Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTENVyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTENVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:54:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262934AbTENVyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:54:06 -0400
Message-ID: <3EC2BDEC.6020401@pobox.com>
Date: Wed, 14 May 2003 18:06:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: airo and firmware upload (was Re: 2.6 must-fix list, v3)
References: <20030514211222.GA10453@bougret.hpl.hp.com>
In-Reply-To: <20030514211222.GA10453@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	o get the latest airo.c fixes from CVS. This will hopefully
> fix problems people have reported on the LKML.

please beg Javier to split up his patch.  He sends me a _huge_ patch 
with tons of changes each time.  If I object to one thing, we spin in 
another huge-patch loop... :/

Sending me 20, 50, 100 patches to the same file is ok.  Even encouraged.


> 	o get HostAP driver in the kernel. No consolidation of the
> 802.11 management across driver can happen until this one is in (which
> is probably 2.7.X material). I think Jouni is mostly ready but didn't
> find time for it.

yeah, there are many requests for this one


> 	o The last two drivers mentioned above are held up by firmware
> issues (see flamewar on LKML a few days ago). So maybe fixing those
> firmware issues should be a requirement for 2.6.X, because we can
> expect more wireless devices to need firmware upload at startup coming
> to market.

> 	As this firmware business seems to me not a wireless specific
> issue (see for example drivers/scsi/qlogicfc_asm.c or
> drivers/atm/atmsar11.data), I would prefer a generic solution to that
> problem, either saying it's OK to put firmware in the kernel (with
> proper licensing) or providing working technical solutions.


We need firmware upload, and, firmware _should_ be uploaded from userspace.

All someone needs to do is actually write the code for their driver to 
receive firmware from userspace, and the rest is easy.  A working 
technical solution is obvious, it just needs interested parties to 
implement.

We can upload firmware from initrd, if no boot device is available at 
the time.

	Jeff



