Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUIGOT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUIGOT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUIGOT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:19:59 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:53720 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S268086AbUIGOTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:19:53 -0400
Message-ID: <413DC38F.5000000@cs.aau.dk>
Date: Tue, 07 Sep 2004 16:19:59 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040619)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <1094220870.7975.19.camel@localhost.localdomain>            <4138CE6F.10501@cs.aau.dk> <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
In-Reply-To: <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 03 Sep 2004 22:05:03 +0200, =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= said:
> 
> 
>>Also simple bufferoverflows in suid-root programs may be avoided. The 
>>simple way would to set the restriction "no fork", and thus if an 
>>attacker tries to fork a (root) shell, this would be denied.
> 
> 
> All this does is stop fork().  I'm not sure, but most shellcodes I've seen
> don't bother forking, they just execve() a shell....
I think you totally misunderstood the thing...

Umbrella is a scheme that allow the user to restrict the capabilities of
a process within his own processes. Preventing the process to fork is
ONE thing that can be restricted but they might be plenty of others.

The idea is that each process originating from this process will inherit
from this restriction (and possibly have some more) and can NEVER been
granted to restore this capability again.

Now, this has a direct application to restrict the harm that can cause a
buffer-overflow, but nobody said that it would stop them...

> Papering over *that* one by restricting fchmod just means the exploit needs to
> append a line to /etc/passwd, or create a trojan inetd.conf or crontab entry,
> or any of the other myriad ways a program can leave a backdoor (there's a
> *reason* SELinux ends up with all those rules - this isn't an easy task)...
> 
> Remember - just papering over the fact that most shellcodes just execve() a
> shell doesn't fix the fundemental problem, which is that the attacker is able
> to run code of his choosing as root.
Right. Now who wants to volunteered to find a simple and yet efficient
solution to this problem? :-)


KS.
