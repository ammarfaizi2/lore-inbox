Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTIRVe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTIRVe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:34:26 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:52143 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262153AbTIRVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:34:24 -0400
Subject: Re: netpoll/netconsole minor tweaks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030918094832.A16499@osdlab.pdx.osdl.net>
References: <20030917112447.A24623@osdlab.pdx.osdl.net>
	 <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk>
	 <20030918094832.A16499@osdlab.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063919555.16536.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Thu, 18 Sep 2003 22:12:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-18 at 17:48, Chris Wright wrote:
> > <pedant>
> > should be cpu_relax();
> > </pedant>
> 
> Hrm, there's many spots that aren't using it.  What's the benefit, less
> power consumption?  Is it worth a patch to convert other things over?

It speeds up hyperthreading CPUs by letting them know that this
paticular thread is waiting for stuff (sched_yield for silicon)

