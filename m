Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUHKWN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUHKWN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268266AbUHKWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:13:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:28131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268263AbUHKWNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:13:24 -0400
Date: Wed, 11 Aug 2004 15:13:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
In-Reply-To: <20040811215915.GA21812@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
 <20040811215915.GA21812@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Aug 2004, Pavel Machek wrote:
> 
> Fine, so perhaps we do not want config option?

The inline spinlocks are _wonderful_ for seeing where the contention is in 
a simple profile.

In contrast, in a profile the out-of-lines ones will show "x% was spent on 
spinlocks". Which doesn't help much when you want to see where the problem 
is.

This was _hugely_ useful, at least for me, for seeing what locks were 
problematic.

		Linus
