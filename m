Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUIDTBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUIDTBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUIDTBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 15:01:13 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:524 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265805AbUIDTA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 15:00:57 -0400
Message-ID: <413A10FE.5050209@cs.aau.dk>
Date: Sat, 04 Sep 2004 21:01:18 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <200409040241.i842fZxa003725@localhost.localdomain>
In-Reply-To: <200409040241.i842fZxa003725@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
>>Also simple bufferoverflows in suid-root programs may be avoided.
> 
> 
> How?
You can (naturally) not avoid the attack and thereby the process from 
crashing - but you can avoid the effects of it. E.g. if you restrict the 
suid-root process form spawning new processes, it would not be able to 
spawn a root shell, programs liks passwd and cdrecord would be good 
candidates to this restriction.


>>                                                                  The 
>>simple way would to set the restriction "no fork", and thus if an 
>>attacker tries to fork a (root) shell, this would be denied.
> 
> 
> A simple exec(2) will do. Or overwriting a file. Or... If you restrict all
> potentially dangerous operations, you have nothing useful left.
> 
> 
>>                                                             Another way 
>>could be to heavily restrict access to the filesystem. If the program is 
>>restricted from /var, the root shell spawned by the attack would not 
>>have access either. (restrictions are enherited from parent to children).
> 
> 
> Just delete /var. Oops, it is there for a purpose...
Sure... but not all programs really need access to this. My calendar on 
my PDA for one do not. It (restricting /var) was, as I hope you 
guessed?, an example!


A cool thing is also, that if you restrict the init process from 
accessing a secific directory, then all processes in the system will be 
restricted from this. This will be utilized by Umbrella, to introduce 
signed files (public key cryptography). The area of the public keys will 
be protected by the kernel - simply by restricting Init from this location.


KS.
