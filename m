Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDPOhK>; Mon, 16 Apr 2001 10:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRDPOhB>; Mon, 16 Apr 2001 10:37:01 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:21767 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131886AbRDPOgu>;
	Mon, 16 Apr 2001 10:36:50 -0400
Date: Mon, 16 Apr 2001 08:39:12 -0600
From: yodaiken@fsmlabs.com
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
Message-ID: <20010416083912.C4036@hq.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.31.0104092242320.11520-100000@penguin.transmeta.com> <8623.986888854@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <8623.986888854@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Tue, Apr 10, 2001 at 08:47:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 08:47:34AM +0100, David Howells wrote:
> 
> Since you're willing to use CMPXCHG in your suggested implementation, would it
> make it make life easier if you were willing to use XADD too?
> 
> Plus, are you really willing to limit the number of readers or writers to be
> 32767? If so, I think I can suggest a way that limits it to ~65535 apiece
> instead...

I'm trying to imagine a case where 32,000 sharing a semaphore was anything but a 
major failure and I can't. To me: the result of an attempt by the 32,768th locker
should be a kernel panic. Is there a reasonable scenario where this is wrong?

	
> 
> David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

