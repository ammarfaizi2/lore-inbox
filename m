Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRD1E3a>; Sat, 28 Apr 2001 00:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132512AbRD1E3U>; Sat, 28 Apr 2001 00:29:20 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:38372 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S132488AbRD1E3I>; Sat, 28 Apr 2001 00:29:08 -0400
Message-Id: <m14t8Vj-001QOfC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Clausen <martin@ostenfeld.dk>
Cc: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@intercode.com.au>
Subject: Re: Kernel Oops when using the Netfilter QUEUE target 
In-Reply-To: Your message of "Fri, 27 Apr 2001 00:48:01 +0200."
             <20010427004801.A3464@ostenfeld.dk> 
Date: Fri, 27 Apr 2001 23:42:15 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010427004801.A3464@ostenfeld.dk> you write:
> On Wed, Apr 25, 2001 at 04:24:46PM +1000, James Morris wrote:
> > Please try the patch below.
> 
> So i did and it seems to work just fine (= no more oops') under 2.4.3/2.4.2-a

James,  I only glanced at the patch, but IIRC it just did
route_me_harder() on everything.  This is, unfortunately, no longer
"Best Practice": the prevailing trend is to reroute only when
something has actually been changed, to avoid overriding the socket
binding, etc.

See mangle for an example (store old values, see if they changed).  I
think this would be more complex, but still possible in your case, no?

Thanks,
Rusty.
--
Premature optmztion is rt of all evl. --DK
