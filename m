Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317291AbSFLPBt>; Wed, 12 Jun 2002 11:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317715AbSFLPBr>; Wed, 12 Jun 2002 11:01:47 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:56027 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317291AbSFLPBe>; Wed, 12 Jun 2002 11:01:34 -0400
Date: Wed, 12 Jun 2002 16:33:11 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "J.S.Souza" <jssouza@pacbell.net>
Cc: xsdg <xsdg@openprojects.net>, <linux-kernel@vger.kernel.org>
Subject: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs
In-Reply-To: <200206121440.HAA21382@gold.he.net>
Message-ID: <Pine.LNX.4.44.0206121629310.17198-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, J.S.Souza wrote:

> I had the exact same problem and few were able to help.  However, here's what 
> I found was _my_ problem.  I wasn't enabling the x86 options in the kernel 
> (duh!).  Make sure that when you compile, you enable "Intel IA32 CPU 
> Microcode Support" and "Model Specific Register Support".  What I ended up 
> doing was taking a stock RedHat .config file for i386 and looking at what 
> they did for their options and started to delete things from there that I 
> don't use or need.  Eventually, I just learned what was necessary for a basic 
> i386 kernel.  Although I was compiling for 2.4.17 kernel.  Good luck, hope 
> this was of some help.

Interesting, but i can't see how that could have fixed your problem. MSR 
support is allowing MSR frobbing in user space and microcode stuff is 
update from userland too. Which also happens much later in boot.

Incorrect CPU perhaps?

Regards,
	Zwane

-- 
http://function.linuxpower.ca
		

