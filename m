Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUHVRab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUHVRab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUHVRaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:30:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12418 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268037AbUHVRaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:30:16 -0400
Date: Sun, 22 Aug 2004 19:31:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, eich@suse.de
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
Message-ID: <20040822173128.GA31054@elte.hu>
References: <2vEzI-Vw-17@gated-at.bofh.it> <m3n00nwepr.fsf@averell.firstfloor.org> <1093176046.24272.68.camel@localhost.localdomain> <20040822142344.GA81458@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822142344.GA81458@muc.de>
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


* Andi Kleen <ak@muc.de> wrote:

> > Xorg and XFree assume the kernel will have intelligent limits. When the
> > range went up the EnableIO code in turn switched to ioperm.
> 
> Which was the wrong thing to do since it is slower.

it is not significantly slower with older kernels or with the patch
applied, and it's safer than an all-ports iopl(3).

	Ingo
