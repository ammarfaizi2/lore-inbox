Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVAHWdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVAHWdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAHWds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:33:48 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:27586 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261957AbVAHWaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:30:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 8 Jan 2005 14:29:49 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501081423010.21679@bigblue.dev.mdolabs.com>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
  <1105113998.24187.361.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org> 
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
  <41DF1F3D.3030006@nortelnetworks.com> <1105220326.24592.98.camel@krustophenia.net>
 <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005, Linus Torvalds wrote:

> Short and sweet: the latency changes are in the noise for SMP, but can be
> seen on UP. I'll look at it a bit more:  since I had to add the coalescing
> code anyway, I might also decide to re-use a buffer page rather than free
> it immediately, since that may help latency for small writes.

Yeah, I noticed you clean the page's magazine down to the bottom. Maybe 
keeping one (or more) page in there might help something, due to cache 
improvements and alloc/free page savings.


- Davide

