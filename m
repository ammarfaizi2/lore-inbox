Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRH0VkX>; Mon, 27 Aug 2001 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269184AbRH0VkN>; Mon, 27 Aug 2001 17:40:13 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:64529 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S269176AbRH0Vjy>; Mon, 27 Aug 2001 17:39:54 -0400
Subject: Re: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: Cliff Albert <cliff@oisec.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, J Sloan <jjs@toyota.com>
In-Reply-To: <20010827232415.A670@oisec.net>
In-Reply-To: <998877465.801.19.camel@phantasy>
	<20010827093835.A15153@oisec.net> <3B8AA02D.6F7561AB@lexus.com>
	<998941465.1993.9.camel@phantasy> <998947154.11860.30.camel@phantasy> 
	<20010827232415.A670@oisec.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 27 Aug 2001 17:40:40 -0400
Message-Id: <998948441.12267.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-08-27 at 17:24, Cliff Albert wrote:
> I ALWAYS run make dep && make clean && make bzImage when building a new 
> kernel 

OK, so that is not the problem...

> It still borks, probably you are having other options in your kernel config
> and sections you don't use may depend on dec_and_lock

No, I have places in my kernel where atomic_dec_and_lock is used.  In
fact, one of the functions I was pasted where it broke was mmput() in
kernel.S (i think from fork.c).  I have that function, and it uses
atomic_dec_and_lock...

So the problem is most certainly something to do with your configuration
not getting the dependency right to use atomic_dec_and_lock

Out of curiosity, what CONFIG CPU are you defined to use? 
 
> First get it to work, and then spend time on keeping it current with alan's
> and linus' tree.

I am working, but it is not my code.  I am merely trying to keep it in
sync with the trees.  I am trying to get it working for those who it
does not compile for, but it works for me and others, so it is hard.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

