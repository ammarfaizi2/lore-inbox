Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132761AbRDDIH4>; Wed, 4 Apr 2001 04:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRDDIHr>; Wed, 4 Apr 2001 04:07:47 -0400
Received: from nl-mail-dmz.cmg-gecis.nl ([195.109.155.100]:51716 "EHLO
	nl-irelay.cmg.nl") by vger.kernel.org with ESMTP id <S132761AbRDDIHg>;
	Wed, 4 Apr 2001 04:07:36 -0400
Message-ID: <B569A4D2254ED2119FE500104BC1D5CD01294138@NL-EIN-MAIL01>
From: Remko van der Vossen <remko.van.der.vossen@cmg.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PThreads in kernel module & network interface
Date: Wed, 4 Apr 2001 09:34:15 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I'm new to this list, so let me introduce myself first, I'm Remko van der
Vossen from Holland, I work for CMG in an internship at the moment. CMG
Eindhoven wants me to set up a project. This project involves making a
TCP/IP implementation for embedded systems. As it is way too hard to develop
something like a TCP/IP stack directly on an embedded system we want to
develop it on a PC. Because all of the targetted platforms will support
POSIX and we'd like to use multithreading we decided to develop on a PC
platform which supported POSIX and preferably was free of charge. Ofcourse
we quickly came to the conclusion that linux would be the best developer
platform, and the added bonus is that we've now got gcc to develop with
which is simply an excellent compiler. I myself am quite new to linux so I'm
quite struggeling with everything.

Now the problem that I'm having. To test the TCP/IP stack in development I
would like to be able to use the Linux network interface, here's problem
number 1, I have no idea how this interface is set up and how I can access
it, could you guys provide me with a link to some information about this? I
presume that the network interface is only accessible by kernel level code,
to solve this problem I wanted to develop the TCP/IP stack as a linux kernel
module. I succeeded in making a simple module, that worked out great. The
second problem is that when I use the PThread functions from this module I
need the pthread library. As you probably know gcc doesn't link the pthread
library into the module, so I tried to do that with ld, that in itself
worked, I successfully linked the pthread library into the module I made,
the problem here was that the pthread library itself also has it's own
dependencies on user level code... I could go on linking in every library
that my module depended on, but I think I'd end up with an enourmous module.
There are addictional problems, I believe LinuxThreads (the PThread
implementation I use) uses malloc to allocate memory, and as far as I know
that is not allowed in kernel level space... Can anybody show me how to
solve these problems...

Thank you in advance,

Remko van der Vossen
CMG Eindhoven
Remko.van.der.Vossen@cmg.nl
