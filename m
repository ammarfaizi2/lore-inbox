Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTGTIHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTGTIHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:07:48 -0400
Received: from [213.39.233.138] ([213.39.233.138]:27583 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263281AbTGTIHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:07:41 -0400
Date: Sun, 20 Jul 2003 10:22:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: junkio@cox.net
Cc: David Dillow <dave@thedillows.org>, linux-kernel@vger.kernel.org,
       Phillip Lougher <phillip@lougher.demon.co.uk>
Subject: Re: [PATCH] Port SquashFS to 2.6
Message-ID: <20030720082217.GA25468@wohnheim.fh-wedel.de>
References: <7vk7ae15ty.fsf@assigned-by-dhcp.cox.net> <1058657738.4233.4.camel@ori.thedillows.org> <7vu19hrc1l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7vu19hrc1l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 July 2003 22:40:22 -0700, junkio@cox.net wrote:
> >>>>> "DD" == David Dillow <dave@thedillows.org> writes:
> 
> DD> Hmm, isn't that 4K allocated on the stack? Ouch.
> 
> Ouch indeed.  I was not looking for these things (I was just
> porting not fixing).  Thank you for pointing it out.  Have a
> couple of questions:
> 
>  - Would it be an acceptable alternative here to use blocking
>    kmalloc upon entry with matching kfree before leaving?
> 
>  - I would imagine that the acceptable stack usage for functions
>    would depend on where they are called and what they call.
>    Coulc you suggest a rule-of-thumb number for
>    address_space_operations.readpage (say, would 1kB be OK but
>    not 3kB?)

As a rule of thumb, stay below 1k or you will get regular email from
me. :)

Depending on where and what you do, a bit more could be ok, but this
is hard to prove and also depends a bit on the architecture.  s390 has
giant stacks because function call overhead is huge, i386 will likely
halve the kernel stack sometime during 2.7 and there is no point is
hiding more easter eggs now - there is enough hidden already.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
