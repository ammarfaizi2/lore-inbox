Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270029AbUIDDWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270029AbUIDDWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270031AbUIDDWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:22:33 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55447 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S270029AbUIDDQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:16:27 -0400
Message-Id: <200409040241.i842fZxa003725@localhost.localdomain>
To: =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= <ks@cs.aau.dk>
cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks 
In-Reply-To: Message from =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= <ks@cs.aau.dk> 
   of "Fri, 03 Sep 2004 22:05:03 +0200." <4138CE6F.10501@cs.aau.dk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 22:41:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= <ks@cs.aau.dk> said:

[...]

> Umbrella is mostly designed for embedded systems (where selinux is 
> overkill) and also it is very easy to understand. Most restrictions will 
> be made to e.g. stop viruses from spreading, and it is quite easy, yet 
> very effective:

> If an email client receives an malformed email (like the countless 
> attacks on outlook), a simple restriction could be for the process 
> handeling the mail would be "$HOME/.addressbook",

A mail handling process with the adressbook off-limit sounds _real_ useful.

>                                                   furthermore, you could 
> specify that attachments executed _from_ the emailprogram would not have 
> access to the network.

I.e., no child of the email program could access the network, not even to
answer a message. Sounds restrictive.

>                        Thus the virus cannot find mail addresses to send 
> itself to - and it cannot even get network access. Simple and effective.

Right.

> Also simple bufferoverflows in suid-root programs may be avoided.

How?

>                                                                   The 
> simple way would to set the restriction "no fork", and thus if an 
> attacker tries to fork a (root) shell, this would be denied.

A simple exec(2) will do. Or overwriting a file. Or... If you restrict all
potentially dangerous operations, you have nothing useful left.

>                                                              Another way 
> could be to heavily restrict access to the filesystem. If the program is 
> restricted from /var, the root shell spawned by the attack would not 
> have access either. (restrictions are enherited from parent to children).

Just delete /var. Oops, it is there for a purpose...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
