Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbTHOVuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTHOVuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:50:09 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:14208 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S271368AbTHOVuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:50:06 -0400
To: Ed L Cashin <ecashin@uga.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 15 Aug 2003 17:50:05 -0400
In-Reply-To: <20030815223912.E21529@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 15 Aug 2003 22:39:12 +0100")
Message-ID: <87smo27fqq.fsf@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
References: <20030815184720.A4D482CE79@lists.samba.org>
	<877k5e8vwe.fsf@uga.edu>
	<20030815223912.E21529@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Fri, Aug 15, 2003 at 05:15:45PM -0400, Ed L Cashin wrote:
>> +		dump_stack();
>> +		BUG();
>
> Is there much point to both dump_stack and BUG() - BUG is supposed to
> provide a calltrace, which dump_stack also does.  Do we really need two
> copies?

On i386 WARN_ON calls dump_stack, but BUG just prints some minimal
helpful info on the console, like this:

------------[ cut here ]------------
kernel BUG at kernel/any.c:36!
invalid operand: 0000 [#1]


-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

