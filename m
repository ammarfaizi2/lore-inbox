Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUJKJvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUJKJvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUJKJvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:51:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37322 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268735AbUJKJvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:51:02 -0400
Date: Mon, 11 Oct 2004 11:51:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041011095101.GA14530@atrey.karlin.mff.cuni.cz>
References: <1097455528.25489.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097455528.25489.9.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Any reason why this totally broken code was ever merged upstream ?
> We debated that again and again... the result of the below code is
> to _REMOVE_ useful information from PCI drivers (suspend to disk vs.
> suspend to RAM) for no good reason, making PCI drivers suddently
> take a different state than any other driver, breaking radeonfb
> suspend code, etc....

Well, old code was not too working, either... In -mm, we decided
s-t-disk vs. s-t-RAM according to global system_state, which did the
trick without touching all the drivers. Unfortunately that part did
not get merged. (And got dropped from -mm; I still have the patch).

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
