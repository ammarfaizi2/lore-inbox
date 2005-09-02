Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVIBUwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVIBUwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVIBUwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:52:04 -0400
Received: from smtpout.mac.com ([17.250.248.45]:46329 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750861AbVIBUwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:52:03 -0400
In-Reply-To: <20050902134108.GA16374@codepoet.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 16:51:49 -0400
To: andersen@codepoet.org
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 09:41:09, Erik Andersen wrote:
> On Thu Sep 01, 2005 at 11:00:16PM -0400, Kyle Moffett wrote:
>> A while ago there was a big discussion about splitting out the
>> userspace-accessible portions of the kernel headers into a separate
>> directory, "kabi", "kernel-abi", "linux-abi", or a half-dozen other
>> suggestions.  Linus sprinkled a bit of holy-penguin-pee on the idea,
>> but nothing ever really happened after that.
>
> Have you seen the linux-libc-headers:
>     http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> which, while not an official part of the kernel, do a pretty
> good job...

Well, the eventual goal of this project would be to eliminate the
need for linux-libc-headers by making that task trivial (IE: Just copy
the kcore/ and kabi/ (or whatever they get called) directories into
/usr/include.  There would probably be some compatibility headers
installed into /usr/include/linux until 2.8 is released or 2.7 is
forked for some major internal modification, but other than that, the
stuff shared by userspace and kernelspace would be only in kcore and
kabi, and eventually the linux/* stuff could remove all the __KERNEL__
ifdefs contained therein.  Right now linux-libc-headers is maintained
by one person at each kernel revision.  It would be much better if
that maintenance load could be undertaken instead by those who create
the code that uses those headers, the kernel developers themselves,
because they surely understand it better and are likely to be able to
do it more easily and accurately.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


