Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUEaFf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUEaFf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 01:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEaFf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 01:35:28 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:17936 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264542AbUEaFfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 01:35:22 -0400
Date: Mon, 31 May 2004 13:44:40 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: ndiamond@despammed.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
In-Reply-To: <200405310250.i4V2ork05673@mailout.despammed.com>
Message-ID: <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au>
References: <200405310250.i4V2ork05673@mailout.despammed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 ndiamond@despammed.com wrote:

> 
> Yes, if we use a real-time Linux and make a daemon cooperate very closely
> with the driver.
> 
> >Maybe you could use lookup tables instead of doing floating point
> >arithmetic.
> 
> You might be right, if the device can only be controlled to position itself
> in say 1,000 different ways, then we could have lookup tables for 1,000
> different intervals of (emulations of) floating-point numbers, that yield
> 1,000 different values of sin.  Another table for cos, another for log10,
> etc.  But I'd still have to write my own emulations for binary operators
> such as +, /, etc., since a 1,000*1,000 lookup table would be too big.

Why not scaled longs (or bigger), scalled to number of significant 
digits. The Taylor series for the trig functions might be a painfull.

Ian

