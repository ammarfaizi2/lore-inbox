Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbUKVE3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUKVE3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 23:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUKVE3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 23:29:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:43688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbUKVE3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 23:29:47 -0500
Date: Sun, 21 Nov 2004 20:29:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andreas Schwab <schwab@suse.de>, Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de>
 <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Nov 2004, Davide Libenzi wrote:
> 
> So it seems it did not work even before, the gdb-SIGTRAP stepping. In 
> 2.6.8 I get a straight segfault just for running it.

Ok, that at least means it's not a regression, although it may be that the 
altered behaviour is enough to make some program work/not-work depending 
on exactly what it is testing. My example is certainly not the only way to 
try to mess up a debugger.

I'm by no means 100% sure that we should encourage the kind of programming 
"skills" I showed with that example program, so in that sense this may not 
be worth worrying about. That said, I do hate the notion of having 
programs that are basically undebuggable, so from a QoI standpoint I'd 
really like to say that you can run my horrid little program under the 
debugger and see it work...

		Linus
