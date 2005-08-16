Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVHPXrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVHPXrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVHPXrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:47:33 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:28864 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750743AbVHPXrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:47:32 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Edwards <edwardsg@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jack Steiner <steiner@sgi.com>
In-Reply-To: <1124235225.25433.1.camel@localhost.localdomain>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>
	 <1123953924.3187.22.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
	 <1123957087.3187.31.camel@laptopd505.fenrus.org>
	 <20050816221223.GA9991@sgi.com>
	 <1124235225.25433.1.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 19:47:14 -0400
Message-Id: <1124236034.5764.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 00:33 +0100, Alan Cox wrote:
> 
> If you use /dev/mem you should know what you are doing. Even with
> "checks" dd if=/dev/zero of=/dev/mem will do bad things. Trapping
> obviously bad cases is fine, but complete sanity checking may actually
> be counter productive.
> 

Sometimes "dd if=/dev/zero of=/dev/mem" is helpful. When I was in Spain
for some time, I needed to transfer lots of pictures to my home machine.
But all I had access to was a broken Windows box that I could ssh but
not scp?  So I (stupidly) started a ftp daemon and started transfering
them that way. I thought that creating a temp account and then changing
the password via ssh would work.  

Well, the next day I was completely rooted (thank god it was only a box
in my DMZ). Still, I was thousands of miles away and needed to kill the
box. If I can't use it, I certainly wont let someone else use it.  They
took over pretty much all control to shutdown the machine remotely.  So
I finally was able to do the duty with "dd if=/dev/zero of=/dev/mem".  

And that's my story where that can be your friend :-)

-- Steve


