Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVAIXTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVAIXTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 18:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAIXTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 18:19:11 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:38272 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261945AbVAIXTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 18:19:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 9 Jan 2005 15:19:04 -0800 (PST)
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
In-Reply-To: <Pine.LNX.4.58.0501082004450.2339@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501082013350.22849@bigblue.dev.mdolabs.com>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
  <1105113998.24187.361.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org> 
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
  <41DF1F3D.3030006@nortelnetworks.com> <1105220326.24592.98.camel@krustophenia.net>
 <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
 <Pine.LNX.4.58.0501082004450.2339@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005, Linus Torvalds wrote:

> Side note: the SMP numbers seem to fluctuate wildly making any
> benchmarking a bit suspect. They probably depend very much on just how
> things get scheduled, and on inter-CPU cache behaviour.

Lmbench results on SMP are bogus. OTOH you can easily make a more 
deterministic SMP pipe bench by making the two tasks affine to two 
different CPUs.


- Davide

