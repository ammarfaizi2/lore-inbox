Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSESECa>; Sun, 19 May 2002 00:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSESEC3>; Sun, 19 May 2002 00:02:29 -0400
Received: from bitmover.com ([192.132.92.2]:22951 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314106AbSESEC2>;
	Sun, 19 May 2002 00:02:28 -0400
Date: Sat, 18 May 2002 21:02:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020518210218.P8794@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020518200540.N8794@work.bitmover.com> <E179HtC-0001cB-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 02:01:25PM +1000, Rusty Russell wrote:
> But as we all know, it is harder to remove a feature from Linux, than
> to get the camel book through the eye of a needle (or something).

It's possible that I'm too tired to have grasped this, but if I have,
you're all wet.  In all cases, read needs to return the number of bytes
successfully moved.  If you ask for N and 1/2 of the way through N you
are going to get a fault, and you return SEGFAULT, now how can I ever
find out that N/2 bytes actually made it out to me?  I want to know that.
If you are arguing that return N/2 is wrong, you are incorrect. 
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
