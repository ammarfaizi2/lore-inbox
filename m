Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTESWKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTESWKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:10:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40884 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263268AbTESWKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:10:47 -0400
Subject: Re: userspace irq balancer
From: Dave Hansen <haveblue@us.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Gerrit Huizenga <gh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
In-Reply-To: <20030519221111.P7061@devserv.devel.redhat.com>
References: <200305191314.06216.pbadari@us.ibm.com>
	 <1053382055.5959.346.camel@nighthawk>
	 <20030519221111.P7061@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053382943.4827.358.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 15:22:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 15:11, Arjan van de Ven wrote:
> On Mon, May 19, 2003 at 03:07:36PM -0700, Dave Hansen wrote:
> 
> > The only thing I'm concerned about is how it's going to be packaged. 
> > I'm envisioning explaining how to get the daemon out of its initrd
> > image, set it up and run it, especially before distros have it
> > integrated.  The stuff that's in the kernel now isn't horribly broken;
> > it's just not optimal for some relatively unusual cases.  
> 
> as for distros: RHL8 and later ship with it on the RH side
> (default enabled as of RHL9).

But, do you see the need for ripping out the current code?  For those of
us that are still running a slightly more primitive distro, it would be
nice to have some pretty effective default behavior, like what is in the
kernel now.

> As for where to start it: I really think an initscript is the logical
> place; there has been some discussion about doing it
> from the initramfs but I don't see real benifit from that; from starting
> init to running the initscripts isn't exactly THIS interrupt/performance
> heavy.

Yeah, I don't think we need it the second the kernel boots :)  Do you
really think this is a 2.6 showstopper?  Since it will require distro
cooperation anyway, and those are many months from releasing a 2.6
distro, do we really need it in place for 2.6.0?

-- 
Dave Hansen
haveblue@us.ibm.com

