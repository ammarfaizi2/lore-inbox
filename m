Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUABUrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUABUrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:47:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:46269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265660AbUABUrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:47:46 -0500
Date: Fri, 2 Jan 2004 12:47:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       albert.cahalan@ccur.com, jim.houston@ccur.com
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility
 mode
In-Reply-To: <20040102203820.GA3147@rudolph.ccur.com>
Message-ID: <Pine.LNX.4.58.0401021247010.5282@home.osdl.org>
References: <20040102194909.GA2990@rudolph.ccur.com>
 <Pine.LNX.4.58.0401021226150.5282@home.osdl.org> <20040102203820.GA3147@rudolph.ccur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Jan 2004, Joe Korty wrote:
>
> Indeed we do, and that is the problem.  32 bit apps by definition use
> the 32 bit version of siginfo_t and the first act the kernel has to do
> on receiving one of these is convert it to 64 bit for consumption by
> the rest of the kernel.  In order to do that, the kernel must know what
> fields in siginfo_t the user has set.

Ahh, a light goes on. Yeah, that's broken. Argh.

		Linus
