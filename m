Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWCGIDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWCGIDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWCGIDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:03:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53633 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751141AbWCGIDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:03:15 -0500
Date: Tue, 7 Mar 2006 13:32:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com,
       akpm@osdl.org
Subject: Re: VFS nr_files accounting
Message-ID: <20060307080206.GB5946@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060305113847.GE21751@in.ibm.com> <20060306.123904.35238417.davem@davemloft.net> <20060307064120.GA5946@in.ibm.com> <20060306.224748.86458359.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306.224748.86458359.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:47:48PM -0800, David S. Miller wrote:
> From: Dipankar Sarma <dipankar@in.ibm.com>
> Date: Tue, 7 Mar 2006 12:11:20 +0530
> 
> > On Mon, Mar 06, 2006 at 12:39:04PM -0800, David S. Miller wrote:
> > > I think we should seriously consider these patches for 2.6.16
> > 
> > Isn't it a little too late in the 2.6.16 cycle ? I would have
> > liked a little more time in -mm. Anyway, it is Linus' call. 
> > I can refresh the patches and submit against latest mainline
> > if Linus and Andrew want.
> 
> Users can run widely published programs to make one's system run out
> of file descriptors and make the machine totaly unusable.
> 
> If that doesn't qualify for something to fix for 2.6.16 I don't know
> what does.  :-)

Not many people have access to shiny new 8-core 32-thread CPUs
(/me turns green saying this) :-)

To be honest I thought Linus' earlier fix that increased
RCU maximum batch size to 1000 had more or less fixed
the issue for most people. I haven't seen it in my testing,
but I agree that we have to take OOMs seriously. I am just being
paranoic here.

Thanks
Dipankar
