Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWB0XWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWB0XWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWB0XWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:22:18 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:16531 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1751504AbWB0XWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:22:17 -0500
Date: Tue, 28 Feb 2006 00:21:53 +0100
From: col-pepper@piments.com
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: o_sync in vfat driver
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s5nm6rm5j68xd1@mail.piments.com>
In-Reply-To: <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com>
User-Agent: Opera M2/8.52 (Linux, build 1631)
X-Ovh-Remote: 80.170.101.26 (d80-170-101-26.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)  
<linux-os@analogic.com> wrote:

> Flash does not get zeroed to be written! It gets erased, which sets all
> the bits to '1', i.e., all bytes to 0xff.

Thanks for the correction, but that does not change the discussion.

> Further, the designers of
> flash disks are not stupid as you assume. The direct access occurs
> to static RAM (read/write stuff).

I'm not assuming anything . Some hardware has been killed by this issue.
http://lkml.org/lkml/2005/5/13/144

It seems that it's you making the assumption that all of these devices are  
manufactured the same way.

The constant dirtying of the buffer will still cause excessive use of the  
flash block hosting the FAT. Clearly not all devices use a load spreading  
mechanism and this can lead to premature failure.


