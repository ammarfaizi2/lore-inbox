Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTLAK6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 05:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTLAK6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 05:58:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:39585 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263325AbTLAK6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 05:58:42 -0500
Date: Mon, 1 Dec 2003 11:58:40 +0100 (MET)
From: "john smith" <john.smith77@gmx.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Kernel modul licensing issues
X-Priority: 3 (Normal)
X-Authenticated: #21322809
Message-ID: <21385.1070276320@www22.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valdis 

> You're probably "in the clear" if that's what's really going on, and 
> can probably go a route similar to NVidia (GPL interface to a binary 
> module). 

I just had a quick look at the current version of nvidia's linux driver

(http://download.nvidia.com/XFree86/Linux-x86/1.0-4496/NVIDIA-Linux-x86-1.0-4496-pkg2.run). 
The source code of the kernel front-end is _not_ GPL. 

It provides both definition for the OS independent symbols used in the 
binary object (!= kernel module) nv-kernel.o and the necessary linux 
kernel module code (and of course it makes use of the API nv.h 
provided by the binary object). 

So, the nvidia kernel module consists of the binary object directly 
linked to the objects compiled from the _non-GPL_ sources. 

> The part I'm not having warm fuzzies about is that the only 
> application that comes to mind that could take a char[] and be totally 
> kernel-independent and that would make sense in the kernel rather than 
> out in userspace is a crypto transform - and that's because closed 
> source crypto is usually not taken seriously. 

I totally agree with you and I can reassure you that the algorithm 
has nothing to do with crypto. 

> Of course, if you're not doing crypto, then you can apply the usual 
> cost/benefit analysis of doing it closed source versus the payoff for 
> an attacker to crack it.... 

Hm, not sure what you mean by "crack it". Maybe you mean that 
it's possible to apply "binary analysis methods" against the implementation 
provided in the binary and then reimplement the algorithm as open source? 
Well, in that case we have to deal with it but that's not my job :) 


Regards, 

John

-- 
Neu bei GMX: Preissenkung für MMS-Versand und FreeMMS!

Ideal für alle, die gerne MMS verschicken:
25 FreeMMS/Monat mit GMX TopMail.
http://www.gmx.net/de/cgi/produktemail

+++ GMX - die erste Adresse für Mail, Message, More! +++

