Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbUKUXPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUKUXPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbUKUXPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:15:49 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:51125 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261847AbUKUXOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:14:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Nov 2004 15:14:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Daniel Jacobowitz <dan@debian.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411211511090.11274@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Linus Torvalds wrote:

> 	void handler(int signo)
> 	{
> 		extern char smc;
> 		smc++;
> 	}
> 
> 		asm volatile("\nsmc:\n\t"
> 			".byte 0xb7\n\t"
> 			".long function"
> 			:"=d" (fnp));
> 		fnp();

You know you're sick, don't you? Making traps inc's to get you in the 
correct opcode to move function in edx->fnp, is indeed fruit of a sick 
mind :=)



- Davide

