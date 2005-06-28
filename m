Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVF1I1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVF1I1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVF1I1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:27:33 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:32197 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261917AbVF1IY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:24:58 -0400
Date: Tue, 28 Jun 2005 05:18:15 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050628081815.GA21412@ime.usp.br>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <42C0FF50.7080300@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C0FF50.7080300@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28 2005, Stefan Richter wrote:
> But again, I don't see how -mm and the stock kernel should differ to that
> respect.

Well, I can only say that this problem is 100% reproducible with my
enclosure.

Perhaps more data is needed here? The 2.6.12 kernel is able to see the
drive without any problems while the -mm kernels aren't. I can provide
anything that you guys want.

Right now, I am using a stock/vanilla kernel, for using the drive.

> You could load ieee1394 with a new parameter that supresses the "Root 
> node is not cycle master capable..." routine:
> # modprobe ieee1394 disable_irm=1
> before ohci1394 and the other 1394 related drivers are loaded.

Ok, I'll disable hotplug, udev etc and try to boot into single user mode
for that as soon as I wake up (I'm going to bed right now---had a lot of
work done for a day).

> > ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> > ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
> 
> What caused these two messages? Did you disconnect the drive at this
> point?

Yes, I did. In both cases, just to see if any messages issued to dmesg were
different when unplugging the drive.

If you have other ideas or if any extra information is necessary, please,
let me know and I'll do my best to provide what you need.


Thank you all for the interest, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
