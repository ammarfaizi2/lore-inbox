Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272064AbTHOWSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272068AbTHOWSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:18:33 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:19072 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S272064AbTHOWS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:18:29 -0400
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
References: <20030815184720.A4D482CE79@lists.samba.org>
	<877k5e8vwe.fsf@uga.edu> <20030815212244.GQ1027@matchmail.com>
	<87k79e7fna.fsf@uga.edu> <20030815220519.GS1027@matchmail.com>
From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 15 Aug 2003 18:18:27 -0400
Message-ID: <87ptj65zv0.fsf@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Fri, Aug 15, 2003 at 05:52:09PM -0400, Ed L Cashin wrote:
...
>> >> +		dump_stack();
>> >> +		BUG();

...
> So does show_stack() halt the kernel?  

I'm not calling show_stack but dump_stack.  For i386 it looks like
handle_BUG in arch/i386/kernel/traps.c is the function that gets run
when BUG raises an exception.

BUG() does halt the system, though.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

