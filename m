Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTESV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTESV6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:58:16 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46171 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263179AbTESV6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:58:14 -0400
Date: Mon, 19 May 2003 22:11:11 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Gerrit Huizenga <gh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       arjanv@redhat.com, Keith Mannthey <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
Message-ID: <20030519221111.P7061@devserv.devel.redhat.com>
References: <200305191314.06216.pbadari@us.ibm.com> <1053382055.5959.346.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053382055.5959.346.camel@nighthawk>; from haveblue@us.ibm.com on Mon, May 19, 2003 at 03:07:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 03:07:36PM -0700, Dave Hansen wrote:

> The only thing I'm concerned about is how it's going to be packaged. 
> I'm envisioning explaining how to get the daemon out of its initrd
> image, set it up and run it, especially before distros have it
> integrated.  The stuff that's in the kernel now isn't horribly broken;
> it's just not optimal for some relatively unusual cases.  

as for distros: RHL8 and later ship with it on the RH side
(default enabled as of RHL9).

As for where to start it: I really think an initscript is the logical
place; there has been some discussion about doing it
from the initramfs but I don't see real benifit from that; from starting
init to running the initscripts isn't exactly THIS interrupt/performance
heavy.
