Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTKYGwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 01:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTKYGwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 01:52:50 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:33820 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262055AbTKYGwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 01:52:49 -0500
From: Jos Hulzink <josh@stack.nl>
To: Linus Torvalds <torvalds@osdl.org>,
       Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Date: Tue, 25 Nov 2003 07:55:07 +0000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20031124222652.16351.qmail@web40910.mail.yahoo.com> <Pine.LNX.4.58.0311241429330.15101@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311241429330.15101@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311250755.07577.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 Nov 2003 22:32, Linus Torvalds wrote:
> Basically, there's something strange going on, which _seems_ to be memory
> corruption, and seems to correlate reasonable well (but not 100%) with
> CONFIG_PREEMPT.
>
> It's actually unlikely to be preemption itself that is broken: it's much
> more likely that some driver or other subsystem is broken, and preempt is
> just better at triggering it by making some race conditions much easier to
> see due to bigger windows for them to happen.
>
> The problem is finding enough of a pattern to the reports to make sense of
> what seems to be the common thread. A lot of people use preemption without
> any trouble.

Maybe brute force is the best way to deal with this nasty one ? I'm thinking: 
It must be rather easy to make a tool that takes a .config file and an 
argument "This kernel seems in trouble Yes / No". If an option is enabled, 
and this kernel config crashes, you increase the likelihood of that option 
(i.e. you increment a counter). If an option is enabled, and this kernel 
doesn't crash. you decrement a counter. In the end, you'll end with 
statistics about which kernel option is likely to cause problems.

Jos

