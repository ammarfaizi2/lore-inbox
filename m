Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135943AbRD2S6H>; Sun, 29 Apr 2001 14:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135873AbRD2S4j>; Sun, 29 Apr 2001 14:56:39 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9989 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135956AbRD2S4g>;
	Sun, 29 Apr 2001 14:56:36 -0400
Date: Sun, 29 Apr 2001 01:05:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion for module .init.{text,data} sections
Message-ID: <20010429010522.A32@(none)>
In-Reply-To: <200104270449.VAA05279@adam.yggdrasil.com> <20010427103519.E679@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010427103519.E679@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Fri, Apr 27, 2001 at 10:35:19AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	A while ago, on linux-kernel, we had a discussion about
> > adding support for __initdata and __init in modules.  Somebody
> > (whose name escapes me) had implemented it by essentially adding
> > a vmrealloc() facility in the kernel.  I think I've thought of a
> > simpler way, that would require almost no kernel changes.
> > 
> [implementation details snipped]
> 
> While you are at this, you could make the .exit.{text,data}
> sections swappable for modules (by allocating swappable pages fro
> them?) and only mark them unswappable, while the module is
> exiting.
> 
> Rationale: A device needed for swaping will never call exit
> stuff, because it is still in use. So I see no obvious race here.

You can't do that. Think about interrupt routine being swapped out.

Kernel is *not* preemptible.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

