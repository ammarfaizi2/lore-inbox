Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTESV4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTESV4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:56:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40107 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262955AbTESV4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:56:01 -0400
Subject: userspace irq balancer
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Cc: Gerrit Huizenga <gh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       arjanv@redhat.com, Keith Mannthey <mannthey@us.ibm.com>
In-Reply-To: <200305191314.06216.pbadari@us.ibm.com>
References: <200305191314.06216.pbadari@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053382055.5959.346.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 15:07:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 13:14, Badari Pulavarty wrote:
> ----------  Forwarded Message  ----------
> 
> Subject: Re: 2.5 closeout
> Date: Mon, 19 May 2003 11:40:05 -0700
> From: Andrew Morton <akpm@digeo.com>
> To: Badari Pulavarty <pbadari@us.ibm.com>
> 
> The attribution wasn't very accurate.  That's me, Arjan, perhaps
> Jeff Garzik.
> 
> The problem is that kird does the wrong thing for some workloads (packet
> forwarding mainly - routing).  We'll never get that right, so we'd like to
> deprecate the in-kernel IRQ balancer and merge Arjan's user-space balancer
> into the kernel tree instead.
> 
> http://people.redhat.com/~arjanv/irqbalance/

The only thing I'm concerned about is how it's going to be packaged. 
I'm envisioning explaining how to get the daemon out of its initrd
image, set it up and run it, especially before distros have it
integrated.  The stuff that's in the kernel now isn't horribly broken;
it's just not optimal for some relatively unusual cases.  

Can we leave the current code as-is, and make the added intelligence
from the userspace one an optional thing for those with unusal setups?
-- 
Dave Hansen
haveblue@us.ibm.com

