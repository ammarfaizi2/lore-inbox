Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTETDMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 23:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTETDMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 23:12:43 -0400
Received: from rth.ninka.net ([216.101.162.244]:21632 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263528AbTETDMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 23:12:42 -0400
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
In-Reply-To: <1053382943.4827.358.camel@nighthawk>
References: <200305191314.06216.pbadari@us.ibm.com>
	 <1053382055.5959.346.camel@nighthawk>
	 <20030519221111.P7061@devserv.devel.redhat.com>
	 <1053382943.4827.358.camel@nighthawk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053401130.6830.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 20:25:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 15:22, Dave Hansen wrote:
> > as for distros: RHL8 and later ship with it on the RH side
> > (default enabled as of RHL9).
> 
> But, do you see the need for ripping out the current code?  For those of
> us that are still running a slightly more primitive distro, it would be
> nice to have some pretty effective default behavior, like what is in the
> kernel now.

You have to install new modutils to even use modules with the 2.5.x
kernel, given that why are we even talking about the "inconvenience"
of installing the usermode IRQ balancer as being a blocker for
ripping out the in-kernel stuff?

The in-kernel stuff MUST go.  It went in because "some benchmark went
faster", but with no "why" describing why it might have improved
performance.  We KNOW it absolutely sucks for routing and firewall
applications.  The in-kernel bits were all a shamans dance, with zero
technical "here is why this makes things go faster" description
attached.  If I remember properly, the changelog message when the
in-kernel irq balancing went in was of the form "this makes some
specweb run go faster".

-- 
David S. Miller <davem@redhat.com>
