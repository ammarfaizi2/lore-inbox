Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbULXO4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbULXO4B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 09:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULXO4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 09:56:01 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:11908 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261409AbULXOzx
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 24 Dec 2004 09:55:53 -0500
Subject: Re: [nptl] Re: OSDL Bug 3770
From: Sebastien Decugis <sebastien.decugis@ext.bull.net>
To: nptl@bullopensource.org
Cc: Loic Domaigne <loic-dev@gmx.net>, piggin@cyberone.com.au,
       Linux-Kernel@Vger.Kernel.ORG
In-Reply-To: <1103624547.23533.137.camel@decugiss.frec.bull.fr>
References: <9785.1103562168@www38.gmx.net> <20041221100934.GA31538@elte.hu>
	 <1103624547.23533.137.camel@decugiss.frec.bull.fr>
Organization: Bull S.A.
Date: Fri, 24 Dec 2004 16:00:25 +0100
Message-Id: <1103900425.3570.8.camel@decugiss.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/12/2004 16:03:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/12/2004 16:03:34,
	Serialize complete at 24/12/2004 16:03:34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > note that my -RT patchset includes scheduler changes that implement
> > "global RT scheduling" on SMP systems. Give it a go, it's at:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > you have to enable CONFIG_PREEMPT_RT to active this feature. 
> 
> [...]
> > 
> > anyway, the first step would be to try this scheduler and give feedback
> > of how well it works for you :-)

Well, I finally was able to test it. But... the test case hangs the
machine with the kernel patch applied :/

No problem applying the patch, nor compiling the kernel.

Then, it randomly fails booting the new kernel, hanging on "hardware
detection" in init process (looks like an issue with the IDE controler
where only the floppy and dvdrom are plugged) but this may be due to
rc3, not to your patch.

When the kernel boots, it behaves consistently, but when I run the test
case it never returns, and even the magic-SysRq does not work anymore.
I've also tested in single-user mode, the behavior is the same.

Sorry I can't tell more about the reason why it hangs, I don't know how
to debug the kernel :/ But I can provide you with the test case binary
in case the compiled source code does not hang for you (as for Nick).

Best regards, and Joyeux Noel!
Seb.

-- 
-------------------------------
Sebastien DECUGIS
NPTL Test & Trace Project
http://nptl.bullopensource.org/

"You may fail if you try.
You -will- fail if you don't."

