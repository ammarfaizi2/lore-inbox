Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVAUTzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVAUTzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVAUTzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:55:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55266 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262477AbVAUTze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:55:34 -0500
Date: Fri, 21 Jan 2005 20:55:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@cpushare.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121195522.GA14982@elte.hu>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121105001.A24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chris Wright <chrisw@osdl.org> wrote:

> * Rik van Riel (riel@redhat.com) wrote:
> > Yes, but do you care about the performance of syscalls
> > which the program isn't allowed to call at all ? ;)
> 
> Heh, no, but it's for every syscall not just denied ones.  Point is
> simply that ptrace (complexity aside) doesn't scale the same.

seccomp is about CPU-intense calculation jobs - the only syscalls
allowed are read/write (and sigreturn). UML implements a full kernel
via ptrace and CPU-intense applications run at native speed.

	Ingo
