Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUEDXWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUEDXWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUEDXWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:22:21 -0400
Received: from ns.suse.de ([195.135.220.2]:57533 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261474AbUEDXWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:22:18 -0400
To: Zan Lynx <zlynx@acm.org>
Cc: chris@scary.beasts.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sigaction, fork, malloc, and futex
References: <200405042015.i44KFb0R001900@emess.mscd.edu>
	<Pine.LNX.4.58.0405042315001.24297@sphinx.mythic-beasts.com>
	<1083711395.29189.10.camel@localhost.localdomain>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I invented skydiving in 1989!
Date: Wed, 05 May 2004 01:16:36 +0200
In-Reply-To: <1083711395.29189.10.camel@localhost.localdomain> (Zan Lynx's
 message of "Tue, 04 May 2004 16:56:36 -0600")
Message-ID: <jed65jn5pn.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx <zlynx@acm.org> writes:

> I am not sure it is really a problem though.  I don't think you should
> be allowed to fork inside a signal handler.  That seems very wrong.

fork is marked async-signal-safe, provided that all atfork handlers are
async-signal-safe.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
