Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUDAHN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUDAHN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:13:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:64156 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262451AbUDAHNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:13:54 -0500
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       David Brownell <david-b@pacbell.net>, viro@math.psu.edu,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040401065534.GD11655@kroah.com>
References: <20040329210219.GA16735@kroah.com>
	 <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com>
	 <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com>
	 <20040330230142.GA13571@kroah.com> <20040330235533.GA9018@kroah.com>
	 <1080699090.1198.117.camel@gaston> <20040331221804.GA4729@kroah.com>
	 <1080784568.1435.37.camel@gaston>  <20040401065534.GD11655@kroah.com>
Content-Type: text/plain
Message-Id: <1080803583.1722.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 17:13:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I just had a loooong discussion with Rusty on that subject, it's
> > indeed a nasty one.
> 
> Ah, he sucks another person into the "module unload" discussion.  My
> sympathies :)

Nah, I started it, since he is about 2 meters from me in the
office, that isn't difficult :)

> I agree, it's a difficult problem to solve, and something we aren't
> going to do for 2.6.  That's one reason why module unload is its own
> config option :)
> 
> Anyway, Rusty's proposal of "never unload, just mark not used" and then
> load a new copy into memory that he did during the OLS timeframe last
> year sounds like the only sane way to get this completely correct, with
> the trade off of never releasing memory.



