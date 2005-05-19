Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVESXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVESXNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVESXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:13:31 -0400
Received: from smtp06.auna.com ([62.81.186.16]:51598 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261324AbVESXKb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:10:31 -0400
Date: Thu, 19 May 2005 23:10:29 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Illegal use of reserved word in system.h
To: linux-kernel@vger.kernel.org
References: <20050518195337.GX5112@stusta.de>
	<6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	<20050519112840.GE5112@stusta.de>
	<Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	<1116505655.6027.45.camel@laptopd505.fenrus.org>
	<428CCD19.6030909@candelatech.com> <428CCE87.2010308@nortel.com>
	<428CCFA7.6010206@candelatech.com> <jeacmqg8ww.fsf@sykes.suse.de>
	<1116541832l.2940l.1l@werewolf.able.es>
	<20050519234126.A31656@flint.arm.linux.org.uk>
In-Reply-To: <20050519234126.A31656@flint.arm.linux.org.uk> (from
	rmk+lkml@arm.linux.org.uk on Fri May 20 00:41:26 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1116544229l.2940l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Fri, 20 May 2005 01:10:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.20, Russell King wrote:
> On Thu, May 19, 2005 at 10:30:32PM +0000, J.A. Magallon wrote:
> > Stupid and portable C++ code follows:
> >...
> > # ifdef __linux__
> > 	strcpy(arch,"x86");
> 
> These two appear to be self-contradictory, unless you define "portable"
> to mean "x86 only"... which would be hardly portable.
> 

Yup, portable to what I needed to port it ;). Will be refined...
It was just a note about how to get info about ram, cpu, os and so on.
Probably soft (MySQL) that needs to know on what processors is being built
just needs to know on how many is being run to start a thread on each one,
or know about the ram to size its caches...

At build time, cpp -dM /dev/null:

linux-x86:
#define i386 1
#define __i386 1
#define __i386__ 1
#define __tune_pentium__ 1
#define __tune_i586__ 1

darwin-ppc:
#define __ppc__ 1

But the interesting part would be how to know at runtime on what
processor I'm running. Will have to look at x86info...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam19 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


