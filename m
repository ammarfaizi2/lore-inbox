Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTKUAvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 19:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTKUAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 19:51:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:46562 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263645AbTKUAvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 19:51:31 -0500
Subject: Re: Upgrading Kernel kills X ...
From: john stultz <johnstul@us.ibm.com>
To: Brian McGrew <brian@visionpro.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <F8E34394F337C74EA249580DEE7C240C111C28@chicken.machinevisionproducts.com>
References: <F8E34394F337C74EA249580DEE7C240C111C28@chicken.machinevisionproducts.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069375582.23569.260.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Nov 2003 16:46:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-20 at 10:25, Brian McGrew wrote:
> I have here a very weird situation which I'm hoping that someone can help me
> resolve.  I'm running RedHat 9.0 on a Dell Poweredge 1600 server.  Now the
> stock install of RedHat 9.0 gives me the 2.4.20-8(smp) kernels accordingly.
> Now if I run RedHat's up2date and pull a new kernel from there, I'm fine.  
> 
> Where I run into problems, is two fold and this is where it gets confusing.
> I have tried manually upgrading my kernel in a couple different ways.  The
> first is that our company develops software for Linux (RedHat 7.3) and
> therefor, we have a custom kernel package that we install as an RPM.  Works
> great on RedHat 7.3 with this Dell PE1600.  The second method is installing
> kernel source and building it myself (2.4-20 as well as 2.6.0-test9).  If I
> build and install a kernel myself or add our typical rpm kernel, my X server
> is toast.  Someone told me to double check that I have framebuffer support
> turned on, so I did and that did not resolve the problem.

I've not found the cause of this, but I've seen a similar issue w/ RHEL
3.0. It seems to have to do w/ glibc being compiled to use some feature
(futexes?) which is not available in self-compiled kernels. I found
replacing the i686 compiled glibc w/ the i386 compiled package solved
the issue for me.  Your mileage may vary. 

I'd be interested to hear the real cause. 

thanks
-john

